<style scoped>
.layout{
    border: 1px solid #d7dde4;
    background: #f5f7f9;
    position: relative;
    border-radius: 4px;
    overflow: hidden;
}
.layout-logo{
    width: 100px;
    height: 30px;
    border-radius: 3px;
    float: left;
    position: relative;
    top: 15px;
    left: 20px;
}
.layout-nav{
    width: 420px;
    margin: 0 auto;
    margin-right: 10px;

}
    .layout-header-bar{
        background: #fff;
        box-shadow: 0 1px 1px rgba(0,0,0,.1);
    }
    .layout-logo-left{
        width: 90%;
        height: 30px;
        background: #5b6270;
        border-radius: 3px;
        margin: 15px auto;
    }
    .menu-icon{
        transition: all .3s;
    }
    .rotate-icon{
        transform: rotate(-90deg);
    }
    .menu-item span{
        display: inline-block;
        overflow: hidden;
        width: 69px;
        text-overflow: ellipsis;
        white-space: nowrap;
        vertical-align: bottom;
        transition: width .2s ease .2s;
    }
    .menu-item i{
        transform: translateX(0px);
        transition: font-size .2s ease, transform .2s ease;
        vertical-align: middle;
        font-size: 16px;
    }
    .collapsed-menu span{
        width: 0px;
        transition: width .2s ease;
    }
    .collapsed-menu i{
        transform: translateX(5px);
        transition: font-size .2s ease .2s, transform .2s ease .2s;
        vertical-align: middle;
        font-size: 22px;
    }
    @media print {
    body * {

        visibility: hidden;
    }
    .print, .print * {
        visibility: visible;
    }
    .print {
        position: absolute;
        left: 0;
        top: 0;
    }
    }
    .hidden {
display: none;
}
</style>
<template>
    <div class="layout">
        <Layout>
            <Header >
                <Menu mode="horizontal" theme="dark" active-name="1">
                    <div class="layout-logo">
                        <img src="/images/LOGO.png">
                    </div>
                    <div class="layout-nav">
                        <MenuItem name="1">
                            <Icon type="ios-power"></Icon>
                            <a href="logout">Logout</a>
                        </MenuItem>
                    </div>
                </Menu>
            </Header>
            <Layout style="min-height: 780px;">
                <Sider hide-trigger :style="{background: '#fff',}">
                    <Menu active-name="1-1" theme="light" width="auto" :open-names="['1']">
                        <Submenu name="1">
                            <template slot="title">
                                <Icon type="ios-paper"></Icon>
                                Booking
                            </template>
                            <MenuItem name="1-1" :to="handleGoToMenu('/newbooking')">New Booking</MenuItem>
                            <MenuItem name="1-2" :to="handleGoToMenu('/bookinglist')">Booking List</MenuItem>
                            <MenuItem name="1-3" :to="handleGoToMenu('/calender')" >Calender View</MenuItem>
                            <!-- <MenuItem name="1-4">Compleated Events</MenuItem> -->
                        </Submenu>
                        <Submenu name="2">
                            <template slot="title">
                                <Icon type="ios-paper"></Icon>
                                Service
                            </template>
                            <MenuItem name="2-1" :to="handleGoToMenu('/payment')">Payment</MenuItem>
                            <MenuItem name="2-2" :to="handleGoToMenu('/bookinglist')">Product Rent</MenuItem>
                            <MenuItem name="2-3" :to="handleGoToMenu('/calender')" >Products</MenuItem>
                            <!-- <MenuItem name="1-4">Compleated Events</MenuItem> -->
                        </Submenu>
                        <Submenu name="3">
                            <template slot="title">
                                <Icon type="ios-cog"></Icon>
                                Settings
                            </template>
                            <!-- <MenuItem name="2-1">Booking Off Day</MenuItem> -->
                        </Submenu>
                    </Menu>
                </Sider>
                <Layout :style="{padding: '0 24px 24px'}">
                    <Breadcrumb :style="{margin: '24px 0'}">
                        <BreadcrumbItem>Home</BreadcrumbItem>
                        <BreadcrumbItem>Item</BreadcrumbItem>
                    </Breadcrumb>
                    <Content :style="{padding: '24px', minHeight: '280px', background: '#fff'}">
                        <router-view></router-view>
                    </Content>
                </Layout>
            </Layout>
        </Layout>
    </div>
</template>
<script>
    export default {
        name: 'app-header',
        methods: {
            handleGoToMenu(d){
                return d
            },
            logout() {
                console.log(10);


            }
        },
        computed: {
        }
    }
</script>
