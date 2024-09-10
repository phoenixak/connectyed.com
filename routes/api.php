<?php

use Illuminate\Http\Request;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\PostsController;
use App\Http\Controllers\API\ProfileController;
use App\Http\Controllers\API\CommentsController;
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

Route::put('/updateprofile', [ProfileController::class, 'updateprofile']);

Route::resource('/comment', CommentsController::class);

Route::controller(CommentsController::class)->group(function () {
    Route::get('comment/list/{post_id}', 'list');
    Route::post('comment/islike', 'isLike');
    Route::post('comment/like', 'like');
    Route::post('comment/unlike', 'unlike');
});