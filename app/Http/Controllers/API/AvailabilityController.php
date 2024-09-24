<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Availability;
use Illuminate\Http\Request;

class AvailabilityController extends Controller
{
    // Store availability slots
    public function store(Request $request)
    {
        $validated = $request->validate([
            'user_id' => 'required|exists:users,id',
            'availabilities' => 'required|array',
            'availabilities.*.start_date' => 'nullable|date',
            'availabilities.*.end_date' => 'nullable|date',
            'availabilities.*.start_time' => 'nullable|date_format:H:i',
            'availabilities.*.end_time' => 'nullable|date_format:H:i',
        ]);

        foreach ($validated['availabilities'] as $availability) {
            Availability::create([
                'user_id' => $validated['user_id'],
                'start_date' => $availability['start_date'],
                'end_date' => $availability['end_date'] ?? $availability['start_date'], // fallback to single date
                'start_time' => $availability['start_time'] ?? null,
                'end_time' => $availability['end_time'] ?? null,
            ]);
        }
        
        return response()->json([
            "success" => true,
            "data" => [],
            "message" => 'Availability created successfully'
        ], 201);
    }

    // Retrieve availability for a matchmaker
    public function index($user_id)
    {
        $availabilities = Availability::where('user_id', $user_id)->get();        
        return response()->json([
            "success" => true,
            "data" => $availabilities,
            "message" => 'Availability created successfully'
        ], 200);
    }
}
