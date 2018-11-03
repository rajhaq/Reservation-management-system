<template>
    <div>
        <Row>
            <Col class="dream-input-main" span="24">
                <Form ref="formInline" inline>
                    <FormItem label="Search">
                        <Input type="text" v-model="search" placeholder="Search">
                            <Icon type="ios-search" slot="prepend"></Icon>
                        </Input>
                    </FormItem>
                    <FormItem label="Choose Dates">
                        <DatePicker type="daterange" placement="bottom-end" @on-change="dateRangeConverter" placeholder="Select date" style="width: 200px"></DatePicker>
                    </FormItem>

                </Form>
                <Button  align="left" @click="showPrint">Print</Button>
                <Table :columns="columns1" :data="searchData"></Table>
            </Col>
        </Row>
        <Modal v-model="printModel" width="740" style="margin-top:20px;" >
        <div  class="print">
            <h2 style="text-align:center">Dreams Gallery</h2>
            <h3>Sale List: Item Wise</h3>
            <h3>Date: {{ filterDate[0] }} to {{ filterDate[1] }}</h3>
            <Table :columns="columns1" :data="searchData"></Table>
        </div>
        <div slot="footer">
        </div>

    </Modal>
        <Modal v-model="editModal" width="360">
            <p slot="header" style="color:#369;text-align:center">
                <Icon type="edit"></Icon>
                <span> Edit {{UpdateValue.zoneName}}</span>
            </p>
            <div >
                <Form ref="editObj" :model="editObj" :rules="ruleValidate" label-position="top">
                        <FormItem label="Name" prop="name">
                            <Input v-model="editObj.name" placeholder="Enter name"></Input>
                        </FormItem>
                        <FormItem label="Number" prop="number">
                            <Input v-model="editObj.number" placeholder="Enter phone number"></Input>
                        </FormItem>
                        <FormItem label="E-mail" prop="mail">
                            <Input v-model="editObj.mail" placeholder="Enter e-mail"></Input>
                        </FormItem>
                        <FormItem label="Hall" prop="hall">
                            <Select v-model="editObj.hall" placeholder="Select hall">
                                <Option value="both">Both</Option>
                                <Option value="small">Top (Small)</Option>
                                <Option value="large">Ground (Small)</Option>
                            </Select>
                        </FormItem>
                        <FormItem label="Event Type" prop="type">
                            <Select v-model="editObj.type" placeholder="Select type">
                                <Option v-for="item in type" :value="item.value" :key="item.value">{{ item.label }}</Option>
                            </Select>
                        </FormItem>
                        <FormItem label="Address" prop="address" >
                            <Input v-model="editObj.address" type="textarea" :autosize="{minRows: 2,maxRows: 5}" placeholder="Enter address..."></Input>
                        </FormItem>
                        <FormItem label="Date" prop="date" >
                            <DatePicker v-model="UpdateValue.date" type="date" :options="options3" placeholder="Select date" @on-change="changeBooking"></DatePicker>
                        </FormItem>

                    </Form>

            </div>
            <div slot="footer">
                <Button type="primary" size="large" long :loading="sending" @click="edit">
                    <span v-if="!loading">Update</span>
                    <span v-else>Updating...</span>
                </Button>
            </div>
        </Modal>
        <Modal v-model="deleteModal" width="360">
            <p slot="header" style="color:#f60;text-align:center">
                <Icon type="close"></Icon>
                <span> Delete {{UpdateValue.zoneName}}</span>
            </p>
            <div style="text-align:center">
                Are you sure you want delete {{UpdateValue.zoneName}}

            </div>
            <div slot="footer">
                <Button type="error" size="large" long :loading="sending" @click="remove">
                    <span v-if="!loading">Delete</span>
                    <span v-else>Deleting...</span>
                </Button>
            </div>
        </Modal>
    </div>
</template>

<script>
    export default {
        data () {
            return {
                search:'',
                dateRange:[],
                editModal:false,
                deleteModal:false,
                printModel:false,
                loading:false,
                sending:false,
                isCollapsed: false,
                options3: {
                disabledDate (date) {
                        return date && date.valueOf() < Date.now() - 86400000;
                    }
                },
                UpdateValue: {
                    indexNumber:null,
                    zoneName:'',
                    id:null,
                    date:'',

                },

                editObj:
                {
                    id:null,
                    name: '',
                    mail: '',
                    number: '',
                    hall: '',
                    type: '',
                    address: '',
                    date:'',
                    shift:1,
                    },
                columns1: [
                    {
                        title: 'Client Name',
                        key: 'name'
                    },
                    {
                        title: 'Email',
                        key: 'mail'
                    },
                    {
                        title: 'Contact',
                        key: 'number'
                    },
                    {
                        title: 'Hall',
                        key: 'hall'
                    },
                    {
                        title: 'Shift',
                        key: 'shiftName'
                    },
                    {
                        title: 'Program Type',
                        key: 'type'
                    },
                    {
                        title: 'Address',
                        key: 'address'
                    },
                    {
                        title: 'Date',
                        key: 'date'
                    },
                    {
                        title: 'Action',
                        key: 'action',
                        width: 150,
                        align: 'center',
                        render: (h, params) => {
                            return h('div', [
                                h('Button', {
                                    props: {
                                        type: 'primary',
                                        size: 'small'
                                    },
                                    style: {
                                        marginRight: '5px'
                                    },
                                    on: {
                                        click: () => {
                                            this.showEdit(params.index)
                                        }
                                    }
                                }, 'Edit'),
                                h('Button', {
                                    props: {
                                        type: 'error',
                                        size: 'small'
                                    },
                                    on: {
                                        click: () => {
                                            this.showRemove(params.index)
                                        }
                                    }
                                }, 'Delete')
                            ]);
                        }
                    }
                ],
                data1: [



                ],

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
        computed: {
            searchData()
            {
                if(this.dateRange[0] && this.dateRange[1])
                {
                    return this.data1.filter((data)=>{
                        return ((data.date>= this.dateRange[0] && data.date<=this.dateRange[1])
                            && (data.name.toUpperCase().match(this.search.toUpperCase())
                            || data.number.toUpperCase().match(this.search.toUpperCase())
                            || data.hall.toUpperCase().match(this.search.toUpperCase())
                            || data.address.toUpperCase().match(this.search.toUpperCase())
                        )

                    );
                        }
                    );
                }
                else
                {
                    return this.data1.filter((data)=>{
                        return (data.name.toUpperCase().match(this.search.toUpperCase())
                        || data.hall.toUpperCase().match(this.search.toUpperCase())
                        || data.address.toUpperCase().match(this.search.toUpperCase())
                        )
                        });
                }


            },

            rotateIcon () {
                return [
                    'menu-icon',
                    this.isCollapsed ? 'rotate-icon' : ''
                ];
            },
            menuitemClasses () {
                return [
                    'menu-item',
                    this.isCollapsed ? 'collapsed-menu' : ''
                ]
            }
        },
        methods: {
            async showPrint (index) {
                this.printModel=true
                await new Promise(resolve => setTimeout(resolve, 500));
                console.log("Print")
                window.print();
            },
            async changeBooking (key) {
                this.editObj.date=key
                this.UpdateValue.date=key
                this.ls();
                if(key)
                {
                    try{
                    let {data} =await  axios({
                        method: 'get',
                        url:`/app/bookingFinder/${key}`
                    })
                    console.log(data)
                    if(data.length==0)
                    {
                        console.log('no data')
                        this.s('Great!','You can choose this date!')
                    }
                    else
                    {
                        console.log('Data')
                    for(let d of data)
                    {
                        if(editObj.shift==data.date)
                        {
                            this.e('Oops!','Already Taken, Please choose another date and shift')
                            this.le();
                        }
                        else
                        {
                        this.s('Great!','New date has been added successfully!')

                        }


                    }


                    }
                    this.lf();
                    }catch(e){
                        this.e('Oops!','Something went wrong, please try again!')
                    this.le();
                    }

                }

            },
            dateRangeConverter(key)
            {
                this.dateRange=key

            },
            collapsedSider () {
                this.$refs.side1.toggleCollapse();
            },
            async zoneAdd(){
                this.loading=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/zone',
                        data: this.formValue
                    })
                    this.data1.unshift(data.status)
                    this.formValue.zoneName=''
                    this.s('Great!','Zone has been added successfully!')

                    this.loading=false
                }catch(e){
                    this.loading=false
                    this.e('Oops!','Something went wrong, please try again!')
                }
            },
             showEdit (index) {

                this.editObj.id=this.data1[index].id
                this.editObj.name=this.data1[index].name
                this.editObj.mail=this.data1[index].mail
                this.editObj.number=this.data1[index].number
                this.editObj.hall=this.data1[index].hall
                this.editObj.type=this.data1[index].type
                this.editObj.address=this.data1[index].address
                this.editObj.date=this.data1[index].date
                this.UpdateValue.date=this.data1[index].date
                this.UpdateValue.name=this.data1[index].name
                this.UpdateValue.indexNumber=index
                this.editModal=true
            },
            showRemove (index) {
                this.UpdateValue.id=this.data1[index].id
                this.UpdateValue.indexNumber=index
                this.deleteModal=true
            },
            async edit(){
                this.sending=true
                try{
                    let {data} =await  axios({
                        method: 'put',
                        url:`/app/booking/${this.editObj.id}`,
                        data: this.editObj
                    })
                    this.data1[this.UpdateValue.indexNumber].name=this.editObj.name
                    this.data1[this.UpdateValue.indexNumber].mail=this.editObj.mail
                    this.data1[this.UpdateValue.indexNumber].number=this.editObj.number
                    this.data1[this.UpdateValue.indexNumber].hall=this.editObj.hall
                    this.data1[this.UpdateValue.indexNumber].type=this.editObj.type
                    this.data1[this.UpdateValue.indexNumber].address=this.editObj.address
                    this.s('Great!','information has been updated successfully!')

                    this.sending=false
                    this.editModal=false
                }catch(e){
                    this.sending=false
                    this.editModal=false
                    this.e('Oops!','Something went wrong, please try again!')
                }
            },
            async remove(){
                this.sending=true
                try{
                    let {data} =await  axios({
                        method: 'delete',
                        url:`/app/booking/${this.UpdateValue.id}`,
                    })
                    this.data1.splice( this.UpdateValue.indexNumber, 1)
                    this.s('Great!','information has been removed successfully!')

                    this.sending=false
                    this.deleteModal=false
                }catch(e){
                    this.sending=false
                    this.deleteModal=false
                    this.e('Oops!','Something went wrong, please try again!')
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
        },

        async created()
        {
            this.ls();
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/booking'
                })
                for(let d of data){
                    if(d.shift==1)
                    d.shiftName='Day'
                    else if(d.shift==2)
                    d.shiftName='Night'
                    else
                    d.shiftName='NO SHIFT'

                }
                this.data1=data;

            this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }
        }

    }
</script>
