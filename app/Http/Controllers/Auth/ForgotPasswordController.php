<?php
namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Password;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail; // Add this import
use Illuminate\Mail\Message;

class ForgotPasswordController extends Controller
{
    public function sendResetLinkEmail(Request $request)
    {
        $request->validate(['email' => 'required|email']);

        try {
            Log::info('Attempting to send password reset link', ['email' => $request->email]);
            
            $status = Password::sendResetLink(
                $request->only('email')
            );

            Log::info('Password reset attempt status:', ['status' => $status]);

            return $status === Password::RESET_LINK_SENT
                ? response()->json(['message' => 'Password reset link sent to your email'])
                : response()->json(['error' => trans($status)], 400);
        } catch (\Exception $e) {
            Log::error('Reset password error:', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            return response()->json(['error' => 'Failed to send reset link: ' . $e->getMessage()], 500);
        }
    }

    private function testMailConfiguration()
    {
        try {
            $config = config('mail');
            Log::info('Current mail configuration:', [
                'host' => config('mail.host'),
                'port' => config('mail.port'),
                'encryption' => config('mail.encryption'),
                'from_address' => config('mail.from.address'),
            ]);
            
            return true;
        } catch (\Exception $e) {
            Log::error('Mail configuration test failed:', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            return false;
        }
    }
}