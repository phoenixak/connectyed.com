<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Meeting extends Model
{
    use HasFactory;

    protected $fillable = [
        'matchmaker_id', 'zoom_meeting_id', 'zoom_meeting_url', 'start_time', 'duration'
    ];

    // A meeting belongs to many clients (users)
    public function clients()
    {
        return $this->belongsToMany(User::class, 'meeting_client', 'meeting_id', 'client_id');
    }

    // A meeting belongs to a matchmaker (host)
    public function matchmaker()
    {
        return $this->belongsTo(User::class, 'matchmaker_id');
    }
}
