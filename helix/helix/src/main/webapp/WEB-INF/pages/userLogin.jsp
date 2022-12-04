<html>
<body>
USER is trying to login at
    <div id="time">
    </div>
    <br>
    <br>
    <div>
    <marquee>Made with Love by Rishika Gupta</marquee>
    </div>
    <script type ="text/javascript">
        function updateTime(){
        document.getElementById("time").innerText=new Date().toString();
        }
        setInterval(updateTime,1000);
    </script>
</body>
</html>