<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Booking extends Model
{
    protected $fillable = [
        'admin_id','date', 'shift','name', 'mail','number', 'hall','type','address'
    ];


    public function admin()
    {
       return $this->belongsTo('App\User','admin_id');
    }
}
