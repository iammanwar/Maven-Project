<form class="form-horizontal" action="account" method="post"
	id="signInAccount">
	<div class="form-group ">
		<div class="col-xs-12">
			<input type="email" name="email" placeholder="Email"
				class="form-control" id="emailAddress" value="">
		</div>
	</div>
	<div class="form-group">
		<div class="col-xs-12">
			<input id="pass1" type="password" name="password"
				placeholder="Password" class="form-control" value="">
		</div>
	</div>
	<div class="form-group ">
		<div class="col-xs-12">
			<div class="checkbox checkbox-info checkbox-circle">
				<input id="checkbox-signup" name="rememberMe" type="checkbox"
					checked> <label for="checkbox-signup"> Save
					browser. </label>
			</div>
		</div>
	</div>
	<div class="form-group text-center m-t-30">
		<div class="col-sm-12">
			<a id="forgrtPassword" class="cursorPointer text-muted"><i
				class="fa fa-lock m-r-5"></i> Forgot your password?</a>
		</div>
	</div>

	<div class="form-group account-btn text-center m-t-10">
		<div class="col-xs-12">
			<button
				class="btn w-md btn-bordered btn-danger waves-effect waves-light"
				type="submit" name="singInButton" value="Sign in">Sign in</button>
		</div>
	</div>
</form>
<!-- validation -->
<script type="text/javascript" src="assets/js/validation.main.js"></script>
<script src="assets/js/custom.validation.js"></script>