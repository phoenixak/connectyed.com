<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Models\User;
use App\Models\Profile;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;


class AuthController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login', 'register']]);
    }
    public function login(Request $request)
    {
        $request->validate([
            'username' => 'required|string',
            'password' => 'required|string',
        ]);
        $credentials = $request->only('username', 'password');
        $token = Auth::attempt($credentials);
        
        if (!$token) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized',                
                'data' => [
                    'User' => ['Invalid Email or Password'] 
                ]
            ], 401);
        }


        $user = Auth::user();
        $profile = $user->profile;
        //$user = Auth::profile();
        return response()->json([
            'success' => true,
            'message' => 'Authorized',
            'data' => compact('user', 'profile'),
            'authorization' => [
                'token' => $token,
                'type' => 'bearer',
            ]
        ]);
    }


    public function register(Request $request)
    {
        try {
            $request->validate([
                'name' => 'required|string|max:255',
                'username' => 'required|string|max:255|unique:users',
                'email' => 'required|string|email|max:255|unique:users',
                'password' => 'required|string|min:6|confirmed',
            ]);
        } catch (\Illuminate\Validation\ValidationException $res) {
            $response = $res->validator->errors();
            return response()->json([
                'success' => false,
                'message' => 'User\'s data not valid',
                'data' => $response
            ]);
        }

        $user = User::create([
            'name' => $request->name,
            'username' => $request->username,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);


        return response()->json([
            'success' => true,
            'message' => 'User created successfully',
            'data' => $user
        ]);
    }


    public function logout()
    {
        Auth::logout();
        return response()->json([
            'success' => true,
            'message' => 'Successfully logged out',
            'data' => null
        ]);
    }


    public function refresh()
    {
        $user = Auth::user();
        $profile = $user->profile;
        
        return response()->json([
            'success' => true,
            'message' => 'Authorized',
            'data' => compact('user', 'profile'),
            'authorization' => [
                'token' => Auth::refresh(),
                'type' => 'bearer',
            ]
        ]);
    }


    public function introspect()
    {
        $user = Auth::user();
        $profile = $user->profile;
        return response()->json([
            'success' => true,
            'message' => 'Authorized',
            'data' => compact('user', 'profile')
        ]);
    }

}
