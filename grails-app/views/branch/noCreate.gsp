<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Create New Branch</title>
	</head>
	<body>
		<content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/branch')}">Branch Maintenance</a>
          <span class="fa fa-chevron-right"></span><span class="current">Create Branch</span>
		</content>

        <content tag="main-content">
		<div id="create-branch" class="content scaffold-create" role="main">

			<div class="message" role="status">Create new branch not allowed due to GL Module and Licensing constraints</div>
                        
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:link action="index"><g:message code="default.cancel.label" args="[entityName]" default="Cancel" /></g:link></li>
                </ul>
            </content>
	</body>
</html>
