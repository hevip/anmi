<?php
//载入ucpass类
require_once('lib/Ucpaas.class.php');

//初始化必填
//填写在开发者控制台首页上的Account Sid
$options['accountsid']='bdb0aebb6740d6dbbc429ebb2d100d3b';
//填写在开发者控制台首页上的Auth Token
$options['token']='82ebdd4d7512cbbf19f7a4a0f03e9aa0';

//初始化 $options必填
$ucpass = new Ucpaas($options);