<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

use App\Models\Profile;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

use Response;

class ProfileController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['getdetail']]);
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
        $profile->location = $request->input('profile.location');
        $profile->age = $request->input('profile.age');
        $profile->haircolor = $request->input('profile.haircolor');
        $profile->weight = $request->input('profile.weight');
        $profile->height = $request->input('profile.height');     
        $profile->height = $request->input('profile.inches');     
        $profile->maritalstatus = $request->input('profile.maritalstatus');
        $profile->children = $request->input('profile.children');
        $profile->religion = $request->input('profile.religion');
        $profile->smoker = $request->input('profile.smoker');
        $profile->drinker = $request->input('profile.drinker');
        $profile->education = $request->input('profile.education');        
        $profile->jobtitle = $request->input('profile.jobtitle');
        $profile->sports = $request->input('profile.sports');
        $profile->hobbies = $request->input('profile.hobbies');
        $profile->english = $request->input('profile.english');
        $profile->languages = $request->input('profile.languages');
        $profile->description = $request->input('profile.description');
        $profile->comment = $request->input('profile.comment');

        $profile->save();        

        return response()->json([
            "success" => true,
            "data" => $profile,
            "message" => 'Success'
        ], 200);
    }

    public function profileimages()
    {
        // Get all files in the 'profiles' directory
        $user = Auth::user();
        $files = Storage::files('public/upload/images/profiles/'.$user->id);
        // Generate URLs for the files
        $imageUrls = array_map(function($file) {
            return asset('storage/' . str_replace('public/', '', $file));
        }, $files);

        return response()->json([
            "success" => true,
            "data" => $imageUrls,
            "message" => 'Success'
        ], 200);        
    }         

    public function uploadimages(Request $request)
    {
        $user = Auth::user();        
        $request->validate([
            'file' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);
    
        $fileName = time().'_'.$request->file->getClientOriginalName();
        $filePath = $request->file('file')->storeAs('upload/images/profiles/'.$user->id, $fileName, 'public');
    
        //return response()->json(['file_path' => $filePath]);
        return response()->json([
            "success" => true,
            "data" => "storage/".$filePath,
            "message" => 'Success'
        ], 200);        
    }

    public function updateavatar(Request $request)
    {
        $user = Auth::user();
        $request->validate([
            'avatar' => 'required|string',
        ]);

        $profile = Profile::where('user_id', $user->id)->firstOrFail();
        $profile->avatar = $request->avatar;
        $profile->save();

        return response()->json([
            "success" => true,
            "data" => $profile->avatar,
            "message" => 'Success'
        ], 200);  
    }

    public function getprofile()
    {
        // Get all files in the 'profiles' directory
        $user = Auth::user();
        $profile = Profile::where('user_id', $user->id)->firstOrFail();

        return response()->json([
            "success" => true,
            "data" => $profile,
            "message" => 'Success'
        ], 200);        
    }  

    public function getdetail($username)
    {
        $profiles = Profile::whereHas('user', function ($query) use ($username) {
            $query->where('username', $username);
        })->firstOrFail();

        return response()->json([
            "success" => true,
            "data" => $profiles,
            "message" => 'Success'
        ], 200);        
    }  

}
