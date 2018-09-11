<style scoped>
.center{
    text-align:center;
}
.color-green{
    width: 100px;
    height: 30px;
    border-radius: 3px;
    float: left;
    position: relative;
    top: 15px;
    left: 20px;
}
.color-red{
    width: 420px;
    margin: 0 auto;
    margin-right: 10px;
}
.marginB
{
    margin-bottom: 24px;
}
</style>
<template>
    <Row>
        <Col span="22" offset="1"  class="marginB">
            <Card class="center">
                <DatePicker v-model="date" type="date" :options="options3" placeholder="Select date" @on-change="changeBooking"></DatePicker>
            </Card>
        </Col>
        <Row :gutter="16"  v-if="date">
            <Col span="12">
                <Card  class="center" v-if="day">
                        <Alert  class="center" type="warning">Day Shift
                            <span slot="desc"></span>
                        </Alert>
                    <p ><Icon type="ios-checkmark-circle" /></p>
                    <p >Already Booked </p>
                    <p><Button type="primary">View Information</Button></p>
                </Card>
                <Card v-else>
                    <Alert  class="center" type="warning">Day Shift
                    <span slot="desc"></span>
                    </Alert >
                    <Form ref="formValueDay" :model="formValueDay" :rules="ruleValidate" label-position="top">
                        <FormItem label="Name" prop="name">
                            <Input v-model="formValueDay.name" placeholder="Enter name"></Input>
                        </FormItem>
                        <FormItem label="Number" prop="number">
                            <Input v-model="formValueDay.number" placeholder="Enter phone number"></Input>
                        </FormItem>
                        <FormItem label="E-mail" prop="mail">
                            <Input v-model="formValueDay.mail" placeholder="Enter e-mail"></Input>
                        </FormItem>
                        <FormItem label="Hall" prop="hall">
                            <Select v-model="formValueDay.hall" placeholder="Select hall">
                                <Option value="both">Both</Option>
                                <Option value="small">Top (Small)</Option>
                                <Option value="large">Ground (Small)</Option>
                            </Select>
                        </FormItem>
                        <FormItem label="Event Type" prop="type">
                            <Select v-model="formValueDay.type" placeholder="Select type">
                                <Option v-for="item in type" :value="item.value" :key="item.value">{{ item.label }}</Option>
                            </Select>
                        </FormItem>
                        <FormItem label="Address" prop="address" >
                            <Input v-model="formValueDay.address" type="textarea" :autosize="{minRows: 2,maxRows: 5}" placeholder="Enter address..."></Input>
                        </FormItem>
                        <FormItem>
                            <Button type="primary" @click="handleSubmit('formValueDay',0)">Submit</Button>
                            <Button @click="handleReset('formValueDay')" style="margin-left: 8px">Reset</Button>
                        </FormItem>
                    </Form>
                </Card>
            </Col>
            <Col span="12" v-if="date">
                <Card class="center" v-if="night">
                        <Alert >Night Shift
                            <span slot="desc"></span>
                        </Alert>
                    <p ><Icon type="ios-checkmark-circle" /></p>
                    <p >Already Booked </p>
                    <p><Button type="primary">View Information</Button></p>
                </Card>
                <Card v-else>
                    <Alert  class="center">Night Shift
                    <span slot="desc"></span>
                    </Alert >
                    <Form ref="formValueNight" :model="formValueNight" :rules="ruleValidate" label-position="top">
                        <FormItem label="Name" prop="name">
                            <Input v-model="formValueNight.name" placeholder="Enter name"></Input>
                        </FormItem>
                        <FormItem label="Number" prop="number">
                            <Input v-model="formValueNight.number" placeholder="Enter phone number"></Input>
                        </FormItem>
                        <FormItem label="E-mail"  prop="mail">
                            <Input v-model="formValueNight.mail" placeholder="Enter e-mail"></Input>
                        </FormItem>
                        <FormItem label="Hall" prop="hall">
                            <Select v-model="formValueNight.hall" placeholder="Select hall">
                                <Option value="both">Both</Option>
                                <Option value="small">Top (Small)</Option>
                                <Option value="large">Ground (Small)</Option>
                            </Select>
                        </FormItem>
                        <FormItem label="Event Type"  prop="type">
                            <Select v-model="formValueNight.type" placeholder="Select type">
                                <Option v-for="item in type" :value="item.value" :key="item.value">{{ item.label }}</Option>
                            </Select>
                        </FormItem>
                        <FormItem label="Address"  prop="address">
                            <Input v-model="formValueNight.address" type="textarea" :autosize="{minRows: 2,maxRows: 5}" placeholder="Enter address..."></Input>
                        </FormItem>
                        <FormItem>
                            <Button type="primary" @click="handleSubmit('formValueNight',1)">Submit</Button>
                            <Button @click="handleReset('formValueNight')" style="margin-left: 8px">Reset</Button>
                        </FormItem>
                    </Form>
                </Card>
            </Col>
        </Row>
    </Row>
</template>
<script>
    export default {
        data () {
            return {
                day:false,
                night:false,
                date:'',
                options3: {
                disabledDate (date) {
                        return date && date.valueOf() < Date.now() - 86400000;
                    }
                },
                options4: {
                    disabledDate (date) {
                        const disabledDay = date.getDate();
                        return disabledDay === 15;
                    }
                },
                bookingList:[],
                formValueDay:
                    {
                    name: '',
                    mail: '',
                    number: '',
                    hall: '',
                    type: '',
                    address: '',
                    date:'',
                    shift:1,
                    },
                formValueNight:
                    {
                    name: '',
                    mail: '',
                    number: '',
                    hall: '',
                    type: '',
                    address: '',
                    date:'',
                    shift:2,
                    },
                type: [
                    {
                        value: 'wedding',
                        label: 'Wedding'
                    },
                    {
                        value: 'reciption',
                        label: 'Reciption'
                    },

                    {
                        value: 'holdu',
                        label: 'Holdu'
                    },
                    {
                        value: 'birthday',
                        label: 'Birthday'
                    },
                    {
                        value: 'corporate',
                        label: 'Corporate'
                    },
                    {
                        value: 'others',
                        label: 'Others'
                    }
                ],
                ruleValidate: {
                    name: [
                        { required: true, message: 'The name cannot be empty', trigger: 'blur' }
                    ],
                    mail: [
                        { required: false}
                    ],
                    address: [
                        { required: false}
                    ],
                    type: [
                        { required: false }
                    ],
                    number: [
                        { required: true, message: 'The number cannot be empty', trigger: 'blur' }
                    ],
                    hall: [
                        { required: true, message: 'Please select the hall', trigger: 'change' }
                    ],
                }
            }
        },
        methods: {
            async changeBooking (key) {
                this.formValueDay.date=key
                this.formValueNight.date=key
                if(key)
                {
                    this.bookingList.splice(0, this.bookingList.length)
                }
                else{
                    return
                }
                console.log(key)
                this.day=false
                this.night=false
                this.ls();
                try{
                let {data} =await  axios({
                    method: 'get',
                    url:`/app/bookingFinder/${key}`
                })
                console.log(data)
                for(let d of data)
                {
                    if(d.shift==1)
                    {
                        this.day=true
                    }
                    else if(d.shift==2)
                    {
                        this.night=true
                    }

                }

                this.bookingList=data
                this.lf();
                }catch(e){
                    this.e('Oops!','Something went wrong, please try again!')
                this.le();
                }
            },
            handleSubmit (name,index) {
                this.$refs[name].validate((valid) => {
                    if (valid) {
                        this.$Message.success('Success!', 'Data Added');
                        this.add(index);
                    } else {
                        this.$Message.error('Fail!');
                    }
                })
            },
            handleReset (name) {

                this.$refs[name].resetFields();
            },
            async add(index){
                this.loading=true
                console.log(index)
                if(index==0)
                {
                    try{
                        let {data} =await  axios({
                            method: 'post',
                            url:'/app/booking/',
                            data: this.formValueDay
                        })
                        this.s('Great!','Booking has been added successfully!')
                        this.bookingList.push(this.formValueDay);
                        this.day=true
                        this.loading=false
                        this.addProductModal=false
                        // this.formValue=null
                    }catch(e){
                        this.loading=false
                        this.e('Oops!','Something went wrong, please try again!')
                    }
                }
                else if(index==1)
                {
                    try{
                        let {data} =await  axios({
                            method: 'post',
                            url:'/app/booking/',
                            data: this.formValueNight
                        })
                        this.s('Great!','Booking has been added successfully!')
                        this.bookingList.push(this.formValueNight);
                        this.night=true
                        this.loading=false
                        this.addProductModal=false
                        // this.formValue=null
                    }catch(e){
                        this.loading=false
                        this.e('Oops!','Something went wrong, please try again!')
                    }
                }
            },
        }
    }
</script>
