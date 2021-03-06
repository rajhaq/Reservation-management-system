<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::resource('/app/booking','BookingController');
Route::get('/newbookingadmin', 'BookingController@newBookingAdmin');
Route::post('/app/post/bookingJS','BookingController@postBookingAddJS');
Route::post('/app/post/booking','BookingController@postBookingAdd')->route('newbooking');
Route::resource('/app/payment','PaymentController');
Route::get('/app/bookingFinder/{date}', 'BookingController@bookingFinder');
Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');
Route::get('app/calender', 'BookingController@calender')->name('calender');

Route::get('/calender/full','HomeController@calender');

Route::get('/logout', function () {
	Auth::logout();
    Session::flush();
	Session::forget('url.intented');
	return redirect("/login");

});
Route::any('{slug}', [
    'uses' => 'HomeController@index',
 ])->where('slug', '([A-z\d-\/_.]+)?');
