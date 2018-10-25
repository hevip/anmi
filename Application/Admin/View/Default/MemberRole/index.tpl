<form id="pagerForm" action="__URL__/index/pid/{$paramter['pid']}" method="post">
    <include file="Public/pagerForm" />
    <input type="hidden" name="pid" value="{$paramter['pid']}"/>
</form>

<div class="pageHeader">
    <form onsubmit="return navTabSearch(this);" action="__URL__/index/pid/{$paramter['pid']}" method="post">
        <div class="searchBar">
            <table class="searchContent">
                <tr>
                    <td></td>
                </tr>
            </table>
            <div class="subBar">
                <!--ul>
                    <li>
                        <div class="buttonActive">
                            <div class="buttonContent">
                                <button type="submit">检索</button>
                            </div>
                        </div>
                    </li>
                </ul-->
            </div>
        </div>
    </form>
</div>

<div class="pageContent">
    <div class="panelBar" style="background:none;">
        <ul class="toolBar">
        	<if condition="$paramter['pid'] gt 0">
            <li>
                <a href="__URL__/index/pid/{$paramter['parent_id']}" class="audit" rel="memberrole" target="navTab">
                    <span>返回上层</span>
                </a>
            </li>
			</if>
            <li>
                <a href="__URL__/add/pid/{$paramter['pid']}" class="add" rel="memberrole" target="dialog" title="添加群组">
                    <i class="iconfont">&#xe601;</i>
                    <span>添加</span>
                </a>
            </li>
            <li>
                <a href="__URL__/edit/id/{sid_user}" class="edit" rel="memberrole" target="dialog" title="编辑群组">
                    <i class="iconfont">&#xe625;</i>
                    <span>编辑</span>
                </a>
            </li>
            <li>
                <a href="__URL__/auth/id/{sid_user}" class="password" target="dialog" rel="memberrole" title="授权">
                    <i class="iconfont">&#xe626;</i>
                    <span>授权</span>
                </a>
            </li>
            <li>
                <a href="__URL__/remove" class="delete" target="selectedTodo" rel="id" posttype="string" title="你确定要批量删除吗？">
                    <i class="iconfont">&#xe611;</i>
                    <span>删除</span>
                </a>
            </li>
        </ul>
    </div>
    <table class="table" width="100%" layoutH="206">
        <thead>
            <tr>
				<th width="3%" class="txtMid">
					<input type="checkbox" group="id" class="checkboxCtrl">
				</th>
				<th width="5%">编号</th>
				<th width="10%">组名</th>
				<th width="10%">上级组</th>
				<th width="35%">描述</th>
				<th width="10%">创建时间</th>
				<th width="5%">排序</th>
				<th width="10%">状态</th>
				<th width="12%">操作</th>
			</tr>
        </thead>
        <tbody>
        <if condition="$dataList|count gt 0">
        <volist name="dataList" id="volist">
            <tr target="sid_user" rel="{$volist['id']}" >
                <td class="txtMid">
                	<input name="id" value="{$volist['id']}" type="checkbox">
				</td>
                <td>{:( $page['pageNum'] - 1 ) * $page['numperpage'] + ( $key + 1 )}</td>
                <td>
                    <a href="__URL__/index/pid/{$volist['id']}" class="alink1" target="navTab" rel="memberrole" title='菜单分组管理'>
                        {$volist['title']}
                    </a>
                </td>
                <td>{$volist['parent_title']?$volist['parent_title']:'已是顶级'}</td>
                <td>{$volist['intro']}</td>
                <td>{$volist['create_time']|date='Y-m-d H:i:s',###}</td>
                <td>{$volist['sort']}</td>
                <td>
	                <if condition="$volist.status eq 0">
	                	<img src="__IMAGES__/ok.png" />
	                <else />
	                	<img src="__IMAGES__/error.png" />
	                </if>
                </td>
                <td>
                    <if condition="$volist['status'] eq 1">
						<a href="__URL__/commSetStatus/id/{$volist['id']}/param/status-0" target="ajaxTodo" class="color_red">[恢复]</a>
                    <else />
						<a href="__URL__/commSetStatus/id/{$volist['id']}/param/status-1" target="ajaxTodo" class="alink1">[禁用]</a>
					</if>
                </td>
            </tr>
        </volist>
        <else />
            <tr><td colspan="10" style="text-align:center;">没有数据!!!</td></tr>
        </if>
        </tbody>
    </table>
    <include file="Public/pagination" />
</div>