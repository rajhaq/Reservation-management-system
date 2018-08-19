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
        <Col span="10" offset="1" v-if="date">
            <Card class="center" v-if="day">
                    <Alert type="warning">Day Shift
                        <span slot="desc"></span>
                    </Alert>
                <p ><Icon type="ios-checkmark-circle" /></p>
                <p >Already Booked </p>
                <p><Button type="primary">View Information</Button></p>
            </Card>
            <Card class="center" v-else>
                <Alert type="warning">Day Shift
                <span slot="desc"></span>
                </Alert >
                <Form ref="formValidate" :model="formValidate" :rules="ruleValidate" label-position="top">
                    <FormItem label="Name" prop="name">
                        <Input v-model="formValidate.name" placeholder="Enter name"></Input>
                    </FormItem>
                    <FormItem label="Number" prop="number">
                        <Input v-model="formValidate.number" placeholder="Enter phone number"></Input>
                    </FormItem>
                    <FormItem label="E-mail" >
                        <Input v-model="formValidate.mail" placeholder="Enter e-mail"></Input>
                    </FormItem>
                    <FormItem label="Hall" prop="hall">
                        <Select v-model="formValidate.hall" placeholder="Select hall">
                            <Option value="both">Both</Option>
                            <Option value="small">Top (Small)</Option>
                            <Option value="large">Ground (Small)</Option>
                        </Select>
                    </FormItem>
                    <FormItem label="Event Type" >
                        <Select v-model="formValidate.type" placeholder="Select type">
                            <Option v-for="item in type" :value="item.value" :key="item.value">{{ item.label }}</Option>
                        </Select>
                    </FormItem>
                    <FormItem label="Address" >
                        <Input v-model="formValidate.address" type="textarea" :autosize="{minRows: 2,maxRows: 5}" placeholder="Enter address..."></Input>
                    </FormItem>
                    <FormItem>
                        <Button type="primary" @click="handleSubmit('formValidate')">Submit</Button>
                        <Button @click="handleReset('formValidate')" style="margin-left: 8px">Reset</Button>
                    </FormItem>
                </Form>
            </Card>
        </Col>
        <Col span="10" offset="2" v-if="date">
            <Card class="center" v-if="night">
                    <Alert >Night Shift
                        <span slot="desc"></span>
                    </Alert>
                <p ><Icon type="ios-checkmark-circle" /></p>
                <p >Already Booked </p>
                <p><Button type="primary">View Information</Button></p>
            </Card>
            <Card class="center" v-else>
                <Alert>Night Shift
                <span slot="desc"></span>
                </Alert >
                <Form ref="formValidate" :model="formValidate" :rules="ruleValidate" label-position="top">
                    <FormItem label="Name" prop="name">
                        <Input v-model="formValidate.name" placeholder="Enter name"></Input>
                    </FormItem>
                    <FormItem label="Number" prop="number">
                        <Input v-model="formValidate.number" placeholder="Enter phone number"></Input>
                    </FormItem>
                    <FormItem label="E-mail">
                        <Input v-model="formValidate.mail" placeholder="Enter e-mail"></Input>
                    </FormItem>
                    <FormItem label="Hall" prop="hall">
                        <Select v-model="formValidate.hall" placeholder="Select hall">
                            <Option value="both">Both</Option>
                            <Option value="small">Top (Small)</Option>
                            <Option value="large">Ground (Small)</Option>
                        </Select>
                    </FormItem>
                    <FormItem label="Event Type">
                        <Select v-model="formValidate.type" placeholder="Select type">
                            <Option v-for="item in type" :value="item.value" :key="item.value">{{ item.label }}</Option>
                        </Select>
                    </FormItem>
                    <FormItem label="Address">
                        <Input v-model="formValidate.address" type="textarea" :autosize="{minRows: 2,maxRows: 5}" placeholder="Enter address..."></Input>
                    </FormItem>
                    <FormItem>
                        <Button type="primary" @click="handleSubmit('formValidate')">Submit</Button>
                        <Button @click="handleReset('formValidate')" style="margin-left: 8px">Reset</Button>
                    </FormItem>
                </Form>
            </Card>
        </Col>
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
                 formValidate: {
                    name: '',
                    mail: '',
                    number: '',
                    hall: '',
                    type: '',
                    address: '',
                    date:''
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
                this.bookingList.splice(0, this.bookingList.length)
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
            handleSubmit (name) {
                this.$refs[name].validate((valid) => {
                    if (valid) {
                        this.$Message.success('Success!', 'Data Added');
                    } else {
                        this.$Message.error('Fail!');
                    }
                })
            },
            handleReset (name) {
                this.$refs[name].resetFields();
            }
        }
    }
</script>
