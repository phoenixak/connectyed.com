<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Profile extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'user_id',
        'matchmaker_id',
        'city',
        'state',
        'country',
        'location',
        'age',
        'gender',
        'weight',
        'height',
        'inches',
        'haircolor',
        'maritalstatus',
        'children',
        'religion',
        'smoker',
        'drinker',
        'education',
        'company',
        'jobtitle',
        'sports',
        'hobbies',
        'english',
        'languages',
        'avatar',
        'description',
        'comment'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // A matchmaker can have many clients
    public function clients()
    {
        return $this->hasMany(Profile::class, 'matchmaker_id');
    }

    // A client belongs to a matchmaker
    public function matchmaker()
    {
        return $this->belongsTo(Profile::class, 'matchmaker_id');
    }
}
