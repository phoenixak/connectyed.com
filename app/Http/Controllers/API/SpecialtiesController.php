<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Specialties;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

use Response;

class SpecialtiesController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api');
    }            

    /**
     * Update the specified resource in storage.
     */
    public function updatespecialties(Request $request)
    {
        $user = Auth::user();       
        // Update specialties details        
        $specialties = $user->specialties;    
        $specialties->minage = $request->input('specialties.minage');
        $specialties->maxage = $request->input('specialties.maxage');
        $specialties->gender = $request->input('specialties.gender');
        $specialties->locations = $request->input('specialties.locations');
        $specialties->save();        

        return response()->json([
            "success" => true,
            "data" => $specialties,
            "message" => 'Success'
        ], 200);
    }   

    public function getspecialties()
    {
        $user = Auth::user();
        $userid = $user->id;
        $specialties = Specialties::with('user')->where('user_id', $userid)->first();
        
        return response()->json([
            "success" => true,
            "data" => $specialties,
            "message" => 'Success'
        ], 200);
    }     

}
