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
        'city',
        'state',
        'country',
        'location',
        'age',
        'weight',
        'height',
        'eyecolor',
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
}
