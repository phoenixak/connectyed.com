<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Models\User;
use App\Models\Profile;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class ClientController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['getClientsByMatchmakerId']]);
    }   

    public function addClients(Request $request)
    {                                 
        if($request->isUpdating){
            return response()->json([
                'success' => true,
                'data' => [],
                'message' => 'Updated successfully.'
            ]);

        }else{
            try {
                $request->validate([
                    'name' => 'required|string|max:255',
                    'email' => 'required|string|email|max:255|unique:users',
                    'avatar' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
                ]);
            } catch (\Illuminate\Validation\ValidationException $res) {
                $response = $res->validator->errors();
                return response()->json([
                    'success' => false,
                    'message' => 'User\'s data not valid',
                    'data' => $response
                ]);
            }    

            $newuser = Auth::user();
            $matchmakerid = $newuser->id;

            $newuser = User::create([
                'name' => $request->name,
                'username' => Self::generateUsername($request->name),
                'email' => $request->email,
                'password' => Hash::make(rand(1000, 9999)),
                'role' => "client",
                'email_verified_at' => now()->format('Y-m-d H:i:s')
            ]);

            $avatarPath = null;       
            
            if ($request->hasFile('avatar')) {            
                $fileName = time().'_'.$request->avatar->getClientOriginalName();
                $filePath = $request->file('avatar')->storeAs('upload/images/profiles/'.$newuser->id, $fileName, 'public');
                $avatarPath = "/storage/".$filePath;
            }        

            $profile = Profile::create([
                'user_id' => $newuser->id,
                'matchmaker_id' => $matchmakerid,
                'city' => $request->city,
                'state' => $request->state,
                'country' => $request->country,
                'location' => $request->currentLocation,
                'age' => $request->age,
                'gender' => $request->gender,
                'haircolor' => $request->hairColor,
                'weight' => $request->weight,
                'height' => $request->heightFeet,
                'inches' => $request->heightInches,
                'maritalstatus' => $request->maritalStatus,
                'children' => $request->children,
                'religion' => $request->religion,
                'smoker' => $request->smoker,
                'drinker' => $request->drinker,
                'education' => $request->education,
                'jobtitle' => $request->jobTitle,
                'sports' => $request->sports,
                'hobbies' => $request->hobbies,
                'english' => $request->englishLevel,
                'languages' => $request->languages,
                'avatar' => $avatarPath
            ]);        

            if($profile){
                return response()->json([
                    'success' => true,
                    'data' => $newuser,
                    'message' => 'Added successfully.'
                ]);
            } else {
                return response()->json([
                    'success' => false,
                    'data' => $newuser,
                    'message' => 'Feiled.'
                ]);
            }

        }                
    }

    public function getClientsByMatchmakerId($matchmakerId)
    {
        $matchmaker = Profile::with('user')->where('matchmaker_id', $matchmakerId)->get();        
        if (!$matchmaker) {
            return response()->json(['error' => 'Matchmaker not found'], 404);
        }        
        return response()->json([
            'success' => true,
            'data' => $matchmaker,
            'message' => 'List of matchmakers clients'
        ]);
    }

    function generateUsername($fullName) {        
        $fullName = Str::slug($fullName);
        $nameParts = explode('-', $fullName);            
        $preferredUsernameLength = 15;
        $username = '';
        foreach ($nameParts as $part) {
            if (strlen($username) + strlen($part) > $preferredUsernameLength) {
                break;
            }
            $username .= $part;
        }
        if (strlen($username) < $preferredUsernameLength) {
            $username .= rand(1000, 9999);
        }    
        return $username;
    }

    
}
