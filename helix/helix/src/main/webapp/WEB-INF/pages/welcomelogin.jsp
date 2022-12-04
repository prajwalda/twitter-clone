<html>
<link rel="shortcut icon" type="image/png" href="/static/images/favicon.ico"/>
<head>


<script
  src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Red+Hat+Mono:wght@300;378&family=Source+Sans+Pro:ital@1&family=Zen+Antique&display=swap');
        *{
          font-family: 'Red Hat Mono', monospace;
        }
        :root{
          --First-color:#161624;
          --Second-color:#f2363c;
          --third-color:#573b8a;
        }
        body{
          margin: 0;
          padding: 0;
          display: flex;
          justify-content: center;
          align-items: center;
          min-height: 100vh;
          background-image: url(https://wallpapercave.com/wp/wp2757874.gif);
          background-size:cover ;
          background-position:right;
        }
        .main{
          width: 350px;
          background-color: #161624aa;
          height: 500px;
          overflow: hidden;
          border-radius: 10px;      //C:\Users\HP\IdeaProjects\helix\helix\src\main\webapp\WEB-INF\pages\signup.jsp
          box-shadow: 5px 20px 50px #000;
        }
        #chk{
          display: none;
        }
        .signup{
          position: relative;
          width:100%;
          height:100%;
        }
        .user-box {
          position: relative;
          width :60%;
          margin:0px auto;
        }
        button{
        	width: 60%;
        	height: 40px;
        	margin: 10px auto;
        	justify-content: center;
        	display: block;
        	color: #fff;
        	background: #573b8a;
        	font-size: 1em;
        	font-weight: bold;
        	margin-top: 10px;
        	outline: none;
        	border: none;
        	border-radius: 5px;
        	transition: .2s ease-in;
        	cursor: pointer;
        }
        button:hover{
          background: #6d44b8;
        }
        .login{
          height: 470px;
          background: #eee;
          border-radius: 60% / 10%;
          transform: translateY(-180px);
          transition: .8s ease-in-out;
        }
        #chk:checked ~ .login{
          transform: translateY(-530px);
        }
        #chk:checked ~ .login label{
          transform: scale(1);
        }
        #chk:checked ~ .signup .sig{
          transform: scale(.6);
          margin-top:10px;
        }
        .user-box label {
          position: absolute;
          top:0px;
          left: 0px;
          font-size: 16px;
          color: #fff;
          pointer-events: none;
          transition: .5s;
        }
        .user-box input {
          padding: 10px 0;
          font-size: 16px;
          color: #fff;
          margin-bottom: 30px;
          border: none;
          border-bottom: 1px solid #fff;
          outline: none;
          background: transparent;
        }
        .user-box input:focus ~ label,
        .user-box input:valid ~ label {
          top: -20px;
          left: 0;
          color: #f2363c;
          font-size: 12px;
          font-weight:bold;
        }
        label[for="chk"] {
        	font-size: 2.3em;
        	justify-content: center;
        	display: flex;
        	font-weight: bold;
        	cursor: pointer;
        	transition: .5s ease-in-out;
        }
        .sig{
          color:#fff;
        	margin: 40px;
        }
        .log{
        	margin: 80px;
        }
        .login label , .login input{
          color:#573b8a;
        }
        .login input{
          border-color:#573b8a;
        }
    </style>
</head>
<body>


	<div class="main">
		<input type="checkbox" id="chk">


			<div class="login">
				<form>
					<label for="chk" class="log" >Login</label>



    <div class="user-box">

      <input id="login-email" type="text" title="Enter Email" required>

      <label>Email</label>

    </div>

    <div class="user-box">

      <input id="login-password" type="password" title="Enter password" required>

      <label>Password</label>

    </div>
            <p style="color:red" id="login-error" ></p>
					<button type = "button" id="btn-login">Login</button>
				</form>
			</div>
	</div>
	<script>
	function validateSignupForm(){
	var email=$("#login-email").val();
	var password=$("#login-password").val();
	var error="";

	if(!email){
        error+="Email is Empty. ";
	}

    if(!password){
        error+="Password is Empty. ";
       	}
    if(password.length <= 5){
            error+="Password length must be greater than 5 char. ";
        }
    $("#login-error").html( error );

    if(error.length > 0){
        return false;
    }

    return true;
	}
	$("#btn-login").click(function(){
      var isValidForm = validateSignupForm();
      if(isValidForm){
      $("#login-error").hide();
      var email=$("#login-email").val();
      var password=$("#login-password").val();

      	var user={
      	"email":email,
      	"password":password
      	};
      	  $.ajax({
                type:"POST",
                url:"/login/welcome",
                data:JSON.stringify(user),
                success:function(response){
                if(!!response){
                    if(response.is_logined === true){
                        location.href="/user/welcome";
                    }else{
                        $("#login-password").val("");
                        $("#login-error").html(response.message);
                        $("#login-error").show();
                    }
                }

                },
                contentType:'application/json'
                });


       }else{
      $("#login-error").show();

      }
    });
	</script>
</body>
</html>