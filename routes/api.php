<?php

use Illuminate\Http\Request;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\PostsController;
use App\Http\Controllers\API\ProfileController;
use App\Http\Controllers\API\SpecialtiesController;
use App\Http\Controllers\API\CommentsController;
use App\Http\Controllers\API\VerificationController;
use App\Http\Controllers\API\AvailabilityController;
use App\Http\Controllers\API\ClientController;
use App\Http\Controllers\API\AdminController;
use App\Http\Controllers\API\ZoomController;
use App\Http\Controllers\Auth\ForgotPasswordController;
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
        Route::get('getdetail/{username}', 'getdetail');        
        Route::get('images', 'profileimages');
        Route::post('uploadimages', 'uploadimages');
        Route::put('updateavatar', 'updateavatar');
        Route::post('uploadavatar', 'uploadavatar');        
    });
});

Route::prefix('specialties')->group(function () {
    Route::controller(SpecialtiesController::class)->group(function () {
        Route::put('update', 'updatespecialties');
        Route::get('getspecialties', 'getspecialties');
        Route::get('getspecialties/{username}', 'getSpecialtiesByUsername');
    });
});

Route::post('/matchmaker/clients', [ClientController::class, 'addClients']);
Route::get('/matchmaker/clients/{id}', [ClientController::class, 'getClientsByMatchmakerId']);

Route::get('/clients', [ClientController::class, 'index']);

Route::get('/availabilities/{user_id}', [AvailabilityController::class, 'index']);
Route::post('/availabilities', [AvailabilityController::class, 'store']);

Route::get('/email/verify/{id}/{hash}', [VerificationController::class, 'verify'])
    ->middleware(['signed'])
    ->name('verification.verify');

Route::post('password/email', [ForgotPasswordController::class, 'sendResetLinkEmail']);
Route::post('password/reset', [ForgotPasswordController::class, 'reset']);

// routes/web.php
Route::get('/admin/candidates', [AdminController::class, 'getCandidates']);
Route::post('/admin/candidates/approve', [AdminController::class, 'approveCandidate']);
Route::get('/admin/clients', [AdminController::class, 'getClients']);

//Route::middleware('web')->get('/zoom/authorize', [ZoomController::class, 'redirectToZoom']);
Route::middleware('web')->get('/zoom/callback', [ZoomController::class, 'handleZoomCallback']);
Route::middleware('web')->post('/zoom/meeting', [ZoomController::class, 'createMeeting']);
Route::middleware('web')->post('/zoom/refresh-token', [ZoomController::class, 'refreshToken']);
Route::middleware('web')->get('/zoom/token', [ZoomController::class, 'myToken']);

Route::get('/zoom/upcoming-meetings', [ZoomController::class, 'getUpcomingMeetings']);