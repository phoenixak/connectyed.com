<?php

use Illuminate\Http\Request;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\PostsController;
use App\Http\Controllers\API\ProfileController;
use App\Http\Controllers\API\CommentsController;
use App\Http\Controllers\API\VerificationController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::prefix('user')->group(function () {
    Route::controller(AuthController::class)->group(function () {
        Route::post('login', 'login');
        Route::post('register', 'register');
        Route::post('logout', 'logout');
        Route::post('refresh', 'refresh');
        Route::get('introspect', 'introspect');
    });
});

Route::prefix('post')->group(function () {
    Route::controller(PostsController::class)->group(function () {
        Route::get('featured', 'featured');
    });
});

Route::resource('/post', PostsController::class);

Route::prefix('profile')->group(function () {
    Route::controller(ProfileController::class)->group(function () {
        Route::put('update', 'updateprofile');
        Route::get('getprofile', 'getprofile');
        Route::get('images', 'profileimages');
        Route::post('uploadimages', 'uploadimages');
        Route::put('updateavatar', 'updateavatar');
    });
});


Route::get('/email/verify/{id}/{hash}', [VerificationController::class, 'verify'])
    ->middleware(['signed'])
    ->name('verification.verify');



