<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;

use Illuminate\Http\Request;
use Illuminate\Auth\Events\Verified;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class VerificationController extends Controller
{
    public function verify(Request $request)
    {        
        // Find the user by ID
        $user = User::find($request->route('id'));
        
        if ($user->hasVerifiedEmail()) {
            return response()->json(['message' => 'Email already verified.'], 200);
        }

        if (! hash_equals((string) $request->route('hash'), sha1($user->getEmailForVerification()))) {
            return response()->json(['message' => 'Invalid verification link.'], 403);
        }

        // Mark the email as verified
        $user->markEmailAsVerified();

        event(new Verified($user));

        return response()->json(['message' => 'Email successfully verified.'], 200);
    }
}
