<%@ Application Language="C#" %>

<script RunAt="server">

    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup

    }

    protected void Application_PreSendRequestHeaders(object sender, EventArgs e)
    {
        HttpContext.Current.Response.Headers.Remove("X-Powered-By");
        HttpContext.Current.Response.Headers.Remove("X-AspNet-Version");
        HttpContext.Current.Response.Headers.Remove("X-AspNetMvc-Version");
        HttpContext.Current.Response.Headers.Remove("Server");
    }
    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown

    }

    //void Application_Error(object sender, EventArgs e)
    //{
    //    Exception obj = Server.GetLastError();

    //    string ErrorStr = "Application_Error " + Server.GetLastError().Message;

    //    // Code that runs when an unhandled error occurs
    //    Exception objErr = Server.GetLastError().GetBaseException();
    //    string err = "Error Caught in Application_Error event\n" +
    //    "Error in: " + Request.Url.ToString() +
    //    "\nError Message:" + objErr.Message.ToString() +
    //    "\nStack Trace:" + objErr.StackTrace.ToString();
    //    //EventLog.WriteEntry("Sample_WebApp", err, EventLogEntryType.Error);
    //    Server.ClearError();
    //    HttpContext.Current.Response.Redirect("~/error/404.html");
    //}

    void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }

</script>
