<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    protected $fillable = [
        'admin_id','booking_id','amount','date', 'remarks','type'
    ];

    public function admin()
    {
       return $this->belongsTo('App\User','admin_id');
    }
}
