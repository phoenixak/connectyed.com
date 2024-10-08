<?php

namespace App\Http\Controllers\API;
use App\Http\Controllers\Controller;

use Illuminate\Http\Request;
use GuzzleHttp\Client;
use Illuminate\Support\Facades\Http;
use Carbon\Carbon;
use App\Models\User;
use App\Models\Meeting;
use Illuminate\Support\Facades\Notification;
use Illuminate\Support\Facades\Auth;
use App\Notifications\MeetingScheduledNotification;

class ZoomController extends Controller
{    
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['handleZoomCallback', 'redirectToZoom', 'createMeetingInstant', 'createMeeting', 'refreshZoomToken']]);
    } 

    public function redirectToZoom() {
        $query = http_build_query([
            'response_type' => 'code',
            'client_id' => env('ZOOM_CLIENT_ID'),
            'redirect_uri' => env('ZOOM_REDIRECT_URI'),
        ]);

        return redirect(env('ZOOM_AUTH_URL') . '?' . $query);
    }
    
    public function handleZoomCallback(Request $request) {
        $response = Http::asForm()->post('https://zoom.us/oauth/token', [
            'grant_type' => 'authorization_code',
            'code' => $request->code,
            'redirect_uri' => env('ZOOM_REDIRECT_URI'),
            'client_id' => env('ZOOM_CLIENT_ID'),
            'client_secret' => env('ZOOM_CLIENT_SECRET'),
        ]);

        $tokenData = $response->json();
        session(['zoom_access_token' => $tokenData['access_token']]);
        return ($tokenData) ? $tokenData['access_token'] : false;
    }

    // Create Zoom Meeting
    public function createMeetingInstant(Request $request) {
        $accessToken = session('zoom_access_token');

        $response = Http::withToken($accessToken)->post('https://api.zoom.us/v2/users/me/meetings', [
            'topic' => $request->get('topic'),
            'type' => 1,  // Instant meeting
            'settings' => [
                'host_video' => true,
                'participant_video' => true,
            ],
        ]);

        return $response->json();
    }

    public function createMeeting(Request $request)
    {
        // Validate input
        $request->validate([
            'matchmaker_id' => 'required|exists:users,id',
            'client_ids' => 'required|array|min:1|max:2', // Max 2 clients
            'start_time' => 'required|date',
            'duration' => 'required|in:15,30,60', // 15, 30, or 60 minutes
        ]);
        
        $accessToken = session('zoom_access_token');
        $topic = 'Connectyed - One on One Session';
        $startTime = Carbon::parse($request->start_time)->toIso8601String();
        $duration = $request->duration;
        
        $response =  Http::withToken($accessToken)->post('https://api.zoom.us/v2/users/me/meetings', [
            'json' => [
                'topic' => $topic,
                'type' => 2, 
                'start_time' => $startTime,
                'duration' => $duration,
                'settings' => [
                    'host_video' => true,
                    'participant_video' => true,
                    'waiting_room' => true,
                ]
            ]
        ]);

        if ($response->successful()) {
            $meetingData = $response->json();                
            $meetingId = $meetingData['id'];                
            $startUrl = $meetingData['start_url'];
            $joinUrl = $meetingData['join_url'];

            $meeting = Meeting::create([
                'matchmaker_id' => $request->matchmaker_id,
                'zoom_meeting_id' => $meetingId, 
                'zoom_start_url' => $startUrl, 
                'zoom_meeting_url' => $joinUrl, 
                'start_time' => $request->start_time,
                'duration' => $request->duration,
            ]);

            $meeting->clients()->attach($request->client_ids);
            
            foreach ($meeting->clients as $client) {            
                Notification::send($client, new MeetingScheduledNotification($meeting));
            }

            return response()->json([
                "success" => true,
                "data" => $data = [
                    'meeting' => $meeting,      
                    'zoom' => $response->json()
                ],
                "message" => 'Meeting created successfully!'
            ], 200); 
        } else {
            return response()->json([
                "success" => false,
                "data" => [],
                "message" => 'Failed to create Zoom meeting!'
            ], 400);             
        }               
        
    }

    public function refreshZoomToken() {
        $refreshToken = session('zoom_refresh_token');
    
        $response = Http::asForm()->post(env('ZOOM_TOKEN_URL'), [
            'grant_type' => 'refresh_token',
            'refresh_token' => $refreshToken,
            'client_id' => env('ZOOM_CLIENT_ID'),
            'client_secret' => env('ZOOM_CLIENT_SECRET'),
        ]);
    
        $tokenData = $response->json();
        session([
            'zoom_access_token' => $tokenData['access_token'],
            'zoom_refresh_token' => $tokenData['refresh_token'],
        ]);
    }

    public function myToken()
    {
        $zoom_access_token = session('zoom_access_token');
        return response()->json(['token' => $zoom_access_token]);
    }
    
    public function getUpcomingMeetings()
    {
        $user = Auth::user();
        $userId = $user->id;
        // For matchmakers (meetings they created)
        $matchmakerMeetings = Meeting::where('matchmaker_id', $userId)
            ->where('start_time', '>=', now())
            ->with('clients')
            ->get();

        // For clients (meetings they are invited to)
        $clientMeetings = Meeting::whereHas('clients', function($query) use ($userId) {
            $query->where('client_id', $userId);
        })->where('start_time', '>=', now())
        ->with('matchmaker')
        ->get();

        return response()->json([
            "success" => true,
            "data" => $data = [
                'matchmakerMeetings' => $matchmakerMeetings,
                'clientMeetings' => $clientMeetings,
            ],
            "message" => 'Meeting created successfully!'
        ], 200); 
    }

}
