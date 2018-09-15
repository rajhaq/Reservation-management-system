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
                <full-calendar :events="fcEvents" locale="en"
                 @changeMonth="changeMonth"
                @eventClick="eventClick"
                @dayClick="dayClick"
                @moreClick="moreClick">
                </full-calendar>
            </Col>
        </Row>

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
                loading:false,
                sending:false,
                isCollapsed: false,
                UpdateValue: {
                    indexNumber:null,
                    zoneName:'',
                    id:null,

                },
                fcEvents : [
                    {
                    title : 'Sunny Out of Office',
                    start : '2018-09-25',
                    end : '2018-10-27'
                    },
                      {
                        title     : 'event2',
                        start     : '2018-09-02',
                        end       : '2018-09-03',
                        cssClass  : ['family', 'career']
                    }
                ],
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
                        key: 'shift'
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
                        && ( data.type.toUpperCase().match(this.search.toUpperCase())
                        || data.name.toUpperCase().match(this.search.toUpperCase())
                        || data.mail.toString().match(this.search.toString())
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
                        return data.type.toUpperCase().match(this.search.toUpperCase())
                        || data.name.toUpperCase().match(this.search.toUpperCase())
                        || data.mail.toString().match(this.search.toString())
                        || data.number.toUpperCase().match(this.search.toUpperCase())
                        || data.hall.toUpperCase().match(this.search.toUpperCase())
                        || data.address.toUpperCase().match(this.search.toUpperCase())
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
                this.UpdateValue.name=this.data1[index].name
                this.UpdateValue.indexNumber=index
                this.editModal=true
            },
            showRemove (index) {
                this.UpdateValue.zoneName=this.data1[index].zoneName
                this.UpdateValue.id=this.data1[index].id
                this.UpdateValue.indexNumber=index
                this.deleteModal=true
            },
            async edit(){
                this.sending=true
                try{
                    let {data} =await  axios({
                        method: 'put',
                        url:'/app/booking',
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
                        url:`/app/zone/${this.UpdateValue.id}`,
                    })
                    this.data1.splice( this.UpdateValue.indexNumber, 1)
                    this.s('Great!','Zone information has been removed successfully!')

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

    'eventClick' (event, jsEvent, pos) {
       console.log('eventClick', event, jsEvent, pos)
    },
    'dayClick' (day, jsEvent) {
      console.log('dayClick', day, jsEvent)
    },
    'moreClick' (day, events, jsEvent) {
      console.log('moreCLick', day, events, jsEvent)
    }
        },
         components : {
            'full-calendar': require('vue-fullcalendar')
        },

        async created()
        {
            this.ls();
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/booking'
                })
                this.data1=data;

            this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }
        }

    }
</script>
