<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Models\Profile;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

use Response;

class ProfileController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api');
    }            

    /**
     * Update the specified resource in storage.
     */
    public function updateprofile(Request $request)
    {
        $user = Auth::user();

        // Update profile details
        $profile = $user->profile;
        $profile->city = $request->input('profile.city');
        $profile->state = $request->input('profile.state');
        $profile->country = $request->input('profile.country');
        $profile->age = $request->input('profile.age');
        $profile->zodiac = $request->input('profile.zodiac');
        $profile->weight = $request->input('profile.weight');
        $profile->height = $request->input('profile.height');
        $profile->eyecolor = $request->input('profile.eyecolor');
        $profile->haircolor = $request->input('profile.haircolor');
        $profile->maritalstatus = $request->input('profile.maritalstatus');
        $profile->children = $request->input('profile.children');
        $profile->religion = $request->input('profile.religion');
        $profile->smoker = $request->input('profile.smoker');
        $profile->drinker = $request->input('profile.drinker');
        $profile->education = $request->input('profile.education');
        $profile->company = $request->input('profile.company');
        $profile->jobtitle = $request->input('profile.jobtitle');
        $profile->sports = $request->input('profile.sports');
        $profile->hobbies = $request->input('profile.hobbies');
        $profile->english = $request->input('profile.english');
        $profile->languages = $request->input('profile.languages');

        $profile->save();        

        return response()->json([
            "success" => true,
            "data" => $profile,
            "message" => 'Success'
        ], 200);
    }


}
