<template>
    <div>
        <Row>
            <Col class="dream-input-main" span="24">
                <full-calendar :events="data1" locale="en"

                @eventClick="eventClick"
                @dayClick="dayClick"
                @moreClick="moreClick">
                </full-calendar>
            </Col>
        </Row>

        <Modal v-model="editModal" width="360">
            <!-- <p slot="header" style="color:#369;text-align:center">
                <Icon type="edit"></Icon>
                <span> Edit {{UpdateValue.zoneName}}</span>
            </p> -->
            <div>
                <Form ref="editObj" :model="editObj" :rules="ruleValidate" label-position="top">
                        <p>
                            <b>Name: </b>
                            {{ editObj.name }}
                        </p>
                        <p>
                            <b>Number: </b>
                            {{ editObj.number }}
                        </p>
                        <p>
                            <b>E-mail: </b><br/>
                            {{ editObj.mail }}
                        </p>
                        <p></p>
                            <b>Shift: </b>
                            <span v-if="editObj.shift==1">
                                Day
                            </span>
                        <span v-else-if="editObj.shift==2">
                                Night
                            </span>

                        </p>
                        <p>
                            <b>Hall: </b>
                            {{ editObj.hall }}
                        </p>
                        <p>
                            <b>Type: </b>
                            {{ editObj.type }}
                        </p>
                        <p>
                            <b>Address: </b>
                            {{ editObj.address }}
                        </p>


                    </Form>

            </div>

        </Modal>
        <Modal v-model="deleteModal" width="360">
            <p slot="header" style="color:#f60;text-align:center">
                <Icon type="close"></Icon>
                <span> Start Booking</span>
            </p>
            <div style="text-align:center">
                This date is open for booking, Want to Start new booking

            </div>
            <div slot="footer">
                <Button type="error" size="large" long :loading="sending" @click="goDate">
                    <span v-if="!loading">Go</span>
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
                    shift:null,
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
            goDate()
            {

            },
            showEditCal (data) {

                this.editObj.id=data.id
                this.editObj.name=data.name
                this.editObj.mail=data.mail
                this.editObj.number=data.number
                this.editObj.hall=data.hall
                this.editObj.type=data.type
                this.editObj.address=data.address
                this.editObj.date=data.date
                this.editObj.shift=data.shift
                this.UpdateValue.name=data.name
                this.editModal=true
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
                this.showEditCal(event)
            //console.log('eventClick', event, jsEvent, pos)
            },
            'dayClick' (day, jsEvent) {
            //console.log('dayClick', day, jsEvent)

                },
            'moreClick' (day, events, jsEvent) {
            //console.log('moreCLick', day, events, jsEvent)
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
                    url:'/app/calender'
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
