<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Booking;
use Auth;
class BookingController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data=Booking::with('admin')
        ->orderBy('date', 'asc')
        ->get();

        return $data;
    }
    public function calender()
    {
        $data=Booking::with('admin')
        ->orderBy('date', 'desc')
        ->select('*','date AS start','name as title')
        ->get();

        return $data;
    }
public function bookingFinder($date)
    {
        $data=Booking::where('date', $date)
        ->with('admin')
        ->get();

        return $data;
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {

    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $admin_id=Auth::user()->id;
        $input=$request->all();
        $created=Booking::create(
            [
                'admin_id' => $admin_id,
                'date' => $input['date'],
                'shift' => $input['shift'],
                'name' => $input['name'],
                'mail' => $input['mail'],
                'number' => $input['number'],
                'hall' => $input['hall'],
                'type' => $input['type'],
                'address' => $input['address'],
            ]
        );
        $settings=Booking::where('id', $created->id)->with('admin')->first();
        return $settings;
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        Booking::where('id',$id)->update($request->all());
        $update=Booking::where('id',$request->id)->with('admin')->first();
        return $update;
    }
    public function booking(Request $request)
    {
        Booking::where('id',$request->id)->update($request->all());
        $update=Booking::where('id',$request->id)->with('admin')->first();
        return $update;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $destroy = Booking::where('id','=',$id)
          ->first();
          if($destroy->count()){
            $destroy->delete();
            return response()->json(['msg'=>'success','status'=>$id]);
          } else {
            return response()->json(['msg'=>'error','status'=>$id]);
          }
    }
}
