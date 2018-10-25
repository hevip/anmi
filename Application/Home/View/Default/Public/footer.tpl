
<footer>
            <div class="footer-con">
                <div class="CenNav">
                    <a href="{:U('/Service')}" class="Nav_active">
                        <img src="__IMAGES__/secer_52.png"/>
                        服务
                    </a>
                </div>
                <div class="lfrNav">
                    <ul>
                        <li>
                            <a  href="/">
                                <i class="iconfont">&#xe63f;</i>首页
                            </a>
                        </li>
                        <li>
                            <a href="{:U('Product/index')}">
                                <i class="iconfont">&#xe673;</i>产品
                            </a>
                        </li>
                        <li></li>
                        <li>
                            <if condition="$auth neq 0">
                            <a href="{:U('member/unapprovallist')}"><i class="iconfont"><if condition="$hon gt 0"><b style="display: block; width: 0.8rem;
                        height: .8rem; background: #ff3e3e; position: absolute; right: 8rem;
                        border-radius: 100%;"></b></if>&#xe8c0;</i>消息</a>
                            <else />
                                <a href="{:U('member/leaveRecord')}"><i class="iconfont"><if condition="$hon gt 0"><b style="display: block; width: 0.8rem;
                        height: .8rem; background: #ff3e3e; position: absolute; right: 8rem;
                        border-radius: 100%;"></b></if>&#xe8c0;</i>消息</a>
                            </if>
                        </li>
                        <li><a href="{:U('/Member')}"><i class="iconfont">&#xe60f;</i>我的</a></li>
                    </ul>
                </div>
            </div>
        </footer>