<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;
use Illuminate\Auth\Notifications\VerifyEmail;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\Carbon;

class CustomVerifyEmail extends Notification
{
    use Queueable;

    /**
     * Create a new notification instance.
     */
    public function __construct()
    {
        //
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['mail'];
    }

    /**
     * Get the mail representation of the notification.
     */
    public function toMail(object $notifiable): MailMessage
    {
        $verificationUrl = $this->customVerificationUrl($notifiable);

        return (new MailMessage)
            ->subject('Verify Your Email Address')
            ->line('Click the button below to verify your email address.')
            ->action('Verify Email', $verificationUrl)
            ->line('If you did not create an account, no further action is required.');
    }
    
    protected function customVerificationUrl2($notifiable)
    {
        $frontendUrl = url('/') . '/email/verify';
        
        $temporarySignedUrl = URL::temporarySignedRoute(
            'verification.verify',
            Carbon::now()->addMinutes(60),
            ['id' => $notifiable->getKey(), 'hash' => sha1($notifiable->getEmailForVerification())]
        );

        return $frontendUrl . '?verification_url=' . urlencode($temporarySignedUrl);
    }

    protected function customVerificationUrl($notifiable)
    {        
        $hash = sha1($notifiable->getEmailForVerification());
        $id = $notifiable->getKey();
        $signurl = URL::temporarySignedRoute(
            'verification.verify', // Name of the route that handles verification
            Carbon::now()->addMinutes(60), // Expiration time
            ['id' => $id, 'hash' => $hash]
        );

        $frontendUrl = url('/') . '/email/verify';

        
        return "{$frontendUrl}/?verification_url=" . urlencode($signurl);
    }
}
