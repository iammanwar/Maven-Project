
<% if(request.getAttribute("signUpError")!=null){ %>
<div id="toast-container" class="toast-bottom-right animated shake"
	aria-live="polite" role="alert">
	<div class="toast toast-error" style="display: block;">
		<div class="toast-title">Already exists</div>
		<div class="toast-message">That email is taken. Try another.</div>
	</div>
</div>
<% } %>
<% if(request.getAttribute("signInError")!=null){ %>
<div id="toast-container" class="toast-bottom-right animated shake"
	aria-live="polite" role="alert">
	<div class="toast toast-error" style="display: block;">
		<div class="toast-title">Invalid</div>
		<div class="toast-message">Couldn't find your Dak Account</div>
	</div>
</div>
<% } %>




