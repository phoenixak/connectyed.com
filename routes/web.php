<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\VerificationController;

Route::get('{any}', function () {
    return view('welcome');
})->where('any', '.*');

Auth::routes();

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');
