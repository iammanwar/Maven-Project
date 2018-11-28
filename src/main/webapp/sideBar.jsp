
<!-- ========== Left Sidebar Start ========== -->
<div class="left side-menu">
	<div class="sidebar-inner slimscrollleft">

		<!--- Sidemenu -->
		<div id="sidebar-menu">
			<ul>
				<li class="has_sub">
					<button id="composeMiniButton"
						class="btn btn-icon btn-rounded waves-effect waves-light btn-danger animated fadeIn"
						style="margin: 10px; display: none; background-color: #f71f1f !important"
						data-toggle="modal" data-target="#con-close-modal"
						data-backdrop="static" data-keybord="false"
						onclick="composeOpen()">
						<i class="glyphicon glyphicon-edit"></i>
					</button> <a id="composeButton"
					class="btn btn-danger btn-rounded btn-custom w-lg waves-effect waves-light roundCorner"
					style="margin: 20px; background-color: #f71f1f !important"
					data-toggle="modal" data-target="#con-close-modal"
					data-backdrop="static" data-keybord="false" onclick="composeOpen()">Compose</a>
				</li>
				<div>
					<a href="#setting-dropdown" class="waves-effect"
						data-toggle="dropdown" aria-expanded="false" style="width: 100%;"><i
						class="ti-more-alt" style="margin: 50%;"></i> </a>
				</div>
				<div class="dropdown" id="setting-dropdown">
					<ul class="dropdown-menu">
						<li><a href="javascript:void(0)"><i
								class="ion-android-archive m-r-5"></i> Archive</a></li>
					</ul>
				</div>
				<li class="has_sub">
					<!--<a href="javascript:void(0);" class="waves-effect"><i class="mdi mdi-invert-colors"></i> <span> User Interface </span> <span class="menu-arrow"></span></a>-->
					<a href="home.jsp" class="waves-effect"><i
						class="fa fa-inbox m-r-10"></i><span id="totalUnseen"
						class="badge badge-dinfo pull-right"></span><span>Inbox</span></a>
				</li>

				<!--<li class="has_sub">
                                <a href="javascript:void(0);" class="waves-effect"><i class="fa fa-star-o m-r-10"></i><span> Starred </span></span></a>
                            </li>-->
				<li class="has_sub"><a href="draft.jsp" class="waves-effect"><i
						class="fa fa-file-text-o m-r-10"></i><span id="totalDraft"
						class="badge badge-orange pull-right"></span><span> Draft </span></a>

				</li>

				<li class="has_sub"><a href="sentmail.jsp" class="waves-effect"><i
						class="fa fa-paper-plane-o m-r-10"></i><span> Sent Mail </span></a></li>

				<li class="has_sub"><a href="trash.jsp" class="waves-effect"><i
						class="fa fa-trash-o m-r-10"></i><span id="totalTrash"
						class="badge badge-danger pull-right"></span><span> Trash </span></a>
				</li>
			</ul>
		</div>
		<!-- Sidebar -->
	</div>
	<!-- Sidebar -left -->

</div>
<!-- Left Sidebar End -->