<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@ page import="java.util.ArrayList" %> 
  <%@ page import="project.Train" %>  
  <% ArrayList<Train> td =(ArrayList<Train>)request.getAttribute("trainData") ;%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Railways</title>
    <link rel="stylesheet" href="/css/main.min.css" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
      crossorigin="anonymous"
    />

    <style>
      section {
        padding: 60px 0;
      }
      #landing {
        background-image: url("assets/home.jpg");
        height: 100vh;
      }
    </style>
</head>
<body>
<div id="landing">
      <!-- navbar -->
      <nav
        class="navbar navbar-expand-md navbar-light pt-4 pb-4"
        style="background-color: white; opacity: 0.6"
      >
        <div class="container-xxl">
          <!-- navbar brand / title -->
          <a class="navbar-brand" href="#intro">
            <span class="text-secondary fw-bold">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                fill="currentColor"
                class="bi bi-train-freight-front-fill"
                viewBox="0 0 16 16"
              >
                <path
                  d="M5.736 0a1.5 1.5 0 0 0-.67.158L1.828 1.776A1.5 1.5 0 0 0 1 3.118v5.51l2-.6V5a1 1 0 0 1 1-1h8a1 1 0 0 1 1 1v3.028l2 .6v-5.51a1.5 1.5 0 0 0-.83-1.342L10.936.158A1.5 1.5 0 0 0 10.264 0H5.736ZM15 9.672l-5.503-1.65A.5.5 0 0 0 9.353 8H8.5v8h4a2.5 2.5 0 0 0 2.5-2.5V9.672ZM7.5 16V8h-.853a.5.5 0 0 0-.144.021L1 9.672V13.5A2.5 2.5 0 0 0 3.5 16h4Zm-1-14h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1 0-1ZM12 5v2.728l-2.216-.665A1.5 1.5 0 0 0 9.354 7H8.5V5H12ZM7.5 5v2h-.853a1.5 1.5 0 0 0-.431.063L4 7.728V5h3.5Zm-4 5a.5.5 0 1 1 0 1 .5.5 0 0 1 0-1Zm9 0a.5.5 0 1 1 0 1 .5.5 0 0 1 0-1ZM5 13a1 1 0 1 1-2 0 1 1 0 0 1 2 0Zm7 1a1 1 0 1 1 0-2 1 1 0 0 1 0 2Z"
                />
              </svg>
              Railways
            </span>
          </a>
          <!-- toggle button for mobile nav -->
          <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#main-nav"
            aria-controls="main-nav"
            aria-expanded="false"
            aria-label="Toggle navigation"
          >
            <span class="navbar-toggler-icon"></span>
          </button>

          <!-- navbar links -->
          <div
            class="collapse navbar-collapse justify-content-end align-center"
            id="main-nav"
          >
            <ul class="navbar-nav">
              <li class="nav-item">
                <a
                  class="nav-link"
                  href="#topics"
                  data-bs-toggle="modal"
                  data-bs-target="#reg-modal"
                  >Sign Up</a
                >
              </li>
              <li class="nav-item">
                <a
                  class="nav-link"
                  href="#reviews"
                  data-bs-toggle="modal"
                  data-bs-target="#reg-modal"
                  >Loign</a
                >
                
              </li>
              <li class="nav-item">
                <a
                  class="nav-link"
                  href="bookingHistory.jsp"
                  
                  >Booking history</a
                >
              <li class="nav-item">
                <a class="nav-link" href="logout">Log Out</a>
              </li>

              <li class="nav-item ms-2 d-none d-md-inline">
                <a class="btn btn-secondary"
                  ><%=session.getAttribute("name") %></a
                >
              </li>
            </ul>
          </div>
        </div>
      </nav>
      <!-- search  -->
      <div class="row justify-content-center">
        <div
          class="col-lg-8 list-group-item px-4"
          style="background-color: white; opacity: 0.7"
        >
          <!-- <div
              class="list-group-item py-3"
              style="background-color: white; opacity: 0.7"
            > -->
          <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
            <li class="nav-item" role="presentation">
              <button
                class="nav-link active"
                id="pills-home-tab"
                data-bs-toggle="pill"
                data-bs-target="#pills-home"
                type="button"
                role="tab"
                aria-controls="pills-home"
                aria-selected="true"
              >
                Book Tickets
              </button>
            </li>
            
          </ul>
          <div class="tab-content" id="pills-tabContent">
            <div
              class="tab-pane fade show active"
              id="pills-home"
              role="tabpanel"
              aria-labelledby="pills-home-tab"
            >
             <form method="post" action="search">
                        <ul>
                            <b class="fsize"> 
                            From 
                            <input id="src" name="src" type="text" placeholder="Origin Station" required="required" > 
                            </b>
                            <b class="fsize"> To <input id="dest" name="dest" type="text" placeholder="Destination Station" required="required">  </b>
                            <b class="fsize">  Date <input id="date" name="date" type="Date" placeholder="dd-mm-yy">  </b>
                            <label class="fsize"><strong> Class </strong> </label>
                                <select id="class" name="class">
                      
                                 <option value="AC">AC</option>
                                 <option value="Sleeper">Sleeper</option> 
                                 </select>
                           
                        </ul>
                        <button type="submit" >Book Tickets </button>
                    </form>
            </div>
            
            <!-- </div> -->
          </div>
        </div>
      </div>
      <!-- train list -->
      <div class="row justify-content-center">
        <div
          class="col-lg-8 list-group-item px-4"
          style="background-color: white; opacity: 0.7"
        >
        <%
        if(td!=null){
        for(int i=0;i<td.size();i++){
        	
        %>
          <div>
            <p>train name: <%=  td.get(i).getName()%> </p>
            <p>Arrival time <%=  td.get(i).getArrival() %></p>
            
            <button type="submit" class="btn btn-primary"
                data-bs-toggle="modal"
                data-bs-target="#reg-modal" >Book Now </button>
          </div>
          <% }} %>
        </div>
      </div>
    </div>
	
	<!-- modal itself -->
      <div
        class="modal fade"
        id="reg-modal"
        tabindex="-1"
        aria-labelledby="modal-title"
        aria-hidden="true"
      >
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="modal-title">Add passengers</h5>
              <button
                type="button"
                class="btn-close"
                data-bs-dismiss="modal"
                aria-label="Close"
              ></button>
            </div>
            <div class="modal-body">
              <label for="modal-email" class="form-label"
                >Your Name:</label>
              <input
                type="text"
                class="form-control"
                id="modal-email"
                placeholder="e.g. aditya"
              />
              <label for="modal-email" class="form-label">Your Gender:</label>
                <select name="gender" id="gender">
								<option value="M" selected>Male</option>
								<option value="F">Female</option>
								<option value="O">other</option>
							</select>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-primary">Submit</button>
            </div>
          </div>
        </div>
      </div>
    <!-- contact form -->
    <!-- form-control, form-label, form-select, input-group, input-group-text -->
	
	
	<!-- profile -->
	
	<section class="bg-light">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 mb-4 mb-sm-5">
                <div class="card card-style1 border-0">
                    <div class="card-body p-1-9 p-sm-2-3 p-md-6 p-lg-7">
                        <div class="row align-items-center">
                            <div class="col-lg-6 mb-4 mb-lg-0">
                            <% if (new String((String)session.getAttribute("gender")).matches("F")){System.out.println("Female"); %>
                            	                  
                                <img src="https://bootdey.com/img/Content/avatar/avatar3.png" alt="..." />
                           <%  }
                            else if (new String((String)session.getAttribute("gender")).matches("M")){
                            	                   %>
                                <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="..." />
                           <%  }
                            else{
                            	     System.out.println("other"+session.getAttribute("gender"));    %>          
                                <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="..." />
                           <%  }
                            %>
                            </div>
                            <div class="col-lg-6 px-xl-10">
                                <div class="bg-secondary d-lg-inline-block py-1-9 px-1-9 px-sm-6 mb-1-9 rounded"
                                    style="width: 100%;">
                                    <h3 class="h2 text-white mb-0 d-flex justify-content-center"><%=session.getAttribute("name") %>
                                    </h3>
                                    <!-- <span class="text-primary">Coach</span> -->
                                </div>
                                <ul class="list-unstyled mb-1-9">
                                    <!--  <li class="mb-2 mb-xl-3 display-28">
                                        <span class="display-26 text-secondary me-2 font-weight-600">Position:</span>
                                        Coach
                                    </li> -->
                                    <li class="mb-2 mb-xl-3 display-28">
                                        <span class="display-26 text-secondary me-2 font-weight-600">Full Name:</span>
                                        <%=session.getAttribute("name") %> <%=session.getAttribute("lname") %>
                                    </li>
                                    <li class="mb-2 mb-xl-3 display-28">
                                        <span class="display-26 text-secondary me-2 font-weight-600">Id:</span>
                                        <%=session.getAttribute("id") %>
                                    </li>
                                    <li class="mb-2 mb-xl-3 display-28">
                                        <span class="display-26 text-secondary me-2 font-weight-600">Email:</span>
                                        <%=session.getAttribute("email") %>
                                    </li>
                                    
                                    <li class="display-28">
                                        <span class="display-26 text-secondary me-2 font-weight-600">Phone:</span>
                                       <%=session.getAttribute("mobile") %>
                                    </li>
                                </ul>
                                <button class="btn btn-primary" routerLink="/dashboard">
                                    go back
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
	
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
      crossorigin="anonymous"
    ></script>

    <script>
      const tooltips = document.querySelectorAll(".tt");
      tooltips.forEach((t) => {
        new bootstrap.Tooltip(t);
      });
    </script>
</body>
</html>