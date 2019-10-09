<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main" />
    <title>Samples</title>
    <asset:javascript src="editablegrid-2.0.1.js" />
    <asset:stylesheet src="editablegrid-2.0.1.css"/>
  </head>
  <body>
    <content tag="main-content">
      <div class="row">
        <div class="col-md-12">
          <div class="nav-tabs-custom">
            <div class="nav-tab-container">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab_8" data-toggle="tab">Explaining Tab Behavior</a></li>
                <li><a href="#tab_1" data-toggle="tab">Form</a></li>
                <li><a href="#tab_2" data-toggle="tab">Hide/Show Content</a></li>
                <li><a href="#tab_3" data-toggle="tab">Dynamically Add Fields</a></li>
                <li><a href="#tab_4" data-toggle="tab">Form Validators and Maskers</a></li>
                <li><a href="#tab_5" data-toggle="tab">Theme Changer</a></li>
                <li><a href="#tab_6" data-toggle="tab">Data in a Table</a></li>
                <li><a href="#tab_7" data-toggle="tab">Form Components</a></li>
                <li><a href="#tab_9" data-toggle="tab">Alerts and Messages</a></li>
                <li><a href="#tab_10" data-toggle="tab">Editable Grid</a></li>
              </ul>
            </div>
            <div class="tab-content">
              <div class="tab-pane" id="tab_1">
                <h3>Sample Form</h3>
                <form class="form-horizontal" role="form">
                  <div class="form-group">
                    <label for="username" class="control-label">Username</label>
                    <div class="col-sm-4">
                      <input type="text" id="username" class="form-control" name="username" value="" placeholder="Username (case sensitive)" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="password" class="control-label">Password</label>
                    <div class="col-sm-4">
                      <input type="password" id="password" class="form-control" name="password" value="" placeholder="Password (case sensitive)" />
                    </div>
                  </div>
                  <div class="form-group form-buttons">
                    <button type="submit" class="btn btn-primary">Submit</button>
                    <button type="button" class="btn">Cancel</button>
                  </div>
                </form>
                <p>The snippet below illustrates how to create a standard form for your pages. An explanation is given by a comment in gray:</p>
                <pre>
&lt;form class=&quot;form-horizontal&quot; role=&quot;form&quot;&gt; <span>// Use the class form-horizontal for normal forms</span>
  &lt;div class=&quot;form-group&quot;&gt; <span>// Enclose form elements with its label in a div with class form-group</span>
    &lt;label for=&quot;username&quot; class=&quot;control-label&quot;&gt;Username&lt;/label&gt; <span>// Use class control-label for form labels, don't forget to associate the 'for' attribute with the id of the form input</span>
    &lt;div class=&quot;col-sm-4&quot;&gt; <span>// Enclose the input field(s) within a div element and use the class col-sm-9 to spread the input until the edge, or use a lower number than 9 to make the width shorter. In this case, we used col-sm-4 which is less than half the size of col-sm-9</span>
      &lt;input type=&quot;text&quot; id=&quot;username&quot; class=&quot;form-control&quot; name=&quot;username&quot; value=&quot;&quot; placeholder=&quot;Username (case sensitive)&quot; /&gt; <span>// Use the class form-control with input fields, use the attribute 'placeholder' to create input hints in fields</span>
    &lt;/div&gt;
  &lt;/div&gt;
  &lt;div class=&quot;form-group&quot;&gt;
    &lt;label for=&quot;password&quot; class=&quot;control-label&quot;&gt;Password&lt;/label&gt;
    &lt;div class=&quot;col-sm-4&quot;&gt;
      &lt;input type=&quot;password&quot; id=&quot;password&quot; class=&quot;form-control&quot; name=&quot;password&quot; value=&quot;&quot; placeholder=&quot;Password (case sensitive)&quot; /&gt;
    &lt;/div&gt;
  &lt;/div&gt;
  &lt;div class=&quot;form-group form-buttons&quot;&gt; <span>// Enclose form buttons (if any) in a div with class "form-group form-buttons"</span>
    &lt;button type=&quot;submit&quot; class=&quot;btn btn-primary&quot;&gt;Submit&lt;/button&gt; <span>// A button should always have the class btn. If you're implementing a normal button use btn-primary</span>
    &lt;button type=&quot;button&quot; class=&quot;btn&quot;&gt;Cancel&lt;/button&gt; <span>// A class without btn-primary will look like a less-emphasized button. Use this for cancel, reset or any function that empties or resets form contents</span>
  &lt;/div&gt;
&lt;/form&gt;
                </pre>
              </div>
              <div class="tab-pane fade" id="tab_2">
                <h3>Hide or show content based on another field value</h3>
                <p>Select a category from the dropdown and see the additional fields change based on the value of the category dropdown:</p>
                <form class="form-horizontal" role="form">
                  <div class="form-group">
                    <label for="category" class="control-label">Category</label>
                    <div class="col-sm-6">
                      <select type="text" id="category" class="form-control" name="category">
                        <option value="">Select category</option>
                        <option value="Animal">Animal</option>
                        <option value="Plant">Plant</option>
                        <option value="Thing">Thing</option>
                        <option value="Other">Other</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="other_category" class="control-label"></label>
                    <div class="col-sm-6">
                      <input type="text" id="other_category" class="form-control" name="other_category" value="" placeholder="Specify category" data-show-when="category" data-show-when-value="['Other']" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="meow" class="control-label">Does it say meow?</label>
                    <div class="col-sm-6">
                      <div class="col-sm-1">
                        <input id="meow_true" name="meow" class="form-control" type="radio" value="true" data-show-when="category" data-show-when-value="['Animal','Other']" />
                      </div>
                      <div class="col-sm-3">
                        <label for="meow_true" class="control-label">Yes</label>
                      </div>
                      <div class="col-sm-1">
                        <input id="meow_false" name="meow" class="form-control" type="radio" value="false" />
                      </div>
                      <div class="col-sm-3">
                        <label for="meow_false" class="control-label">No</label>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="sunlight" class="control-label">Does it need alot of sunlight?</label>
                    <div class="col-sm-6">
                      <div class="col-sm-1">
                        <input id="sunlight_true" name="sunlight" class="form-control" type="radio" value="true" data-show-when="category" data-show-when-value="['Plant','Other']" />
                      </div>
                      <div class="col-sm-3">
                        <label for="sunlight_true" class="control-label">Yes</label>
                      </div>
                      <div class="col-sm-1">
                        <input id="sunlight_false" name="sunlight" class="form-control" type="radio" value="false" />
                      </div>
                      <div class="col-sm-3">
                        <label for="sunlight_false" class="control-label">No</label>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="vine" class="control-label">Is it a vine?</label>
                    <div class="col-sm-6">
                      <div class="col-sm-1">
                        <input id="vine_true" name="vine" class="form-control" type="radio" value="true" data-show-when="category" data-show-when-value="['Plant','Other']" />
                      </div>
                      <div class="col-sm-3">
                        <label for="vine_true" class="control-label">Yes</label>
                      </div>
                      <div class="col-sm-1">
                        <input id="vine_false" name="vine" class="form-control" type="radio" value="false" />
                      </div>
                      <div class="col-sm-3">
                        <label for="vine_false" class="control-label">No</label>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="soft" class="control-label">Is it soft?</label>
                    <div class="col-sm-6">
                      <div class="col-sm-1">
                        <input id="soft_true" name="soft" class="form-control" type="radio" value="true" data-show-when="category" data-show-when-value="['Thing','Other']" />
                      </div>
                      <div class="col-sm-3">
                        <label for="soft_true" class="control-label">Yes</label>
                      </div>
                      <div class="col-sm-1">
                        <input id="soft_false" name="soft" class="form-control" type="radio" value="false" />
                      </div>
                      <div class="col-sm-3">
                        <label for="soft_false" class="control-label">No</label>
                      </div>
                    </div>
                  </div>
                </form>
                <p>
                  The manner of items appearing or disappearing is based on the attribute 'data-show-when' and paired with 'data-show-when-value'. This is attached to the field to be hidden or shown based
                  on the value of the object mentioned from 'data-shown-when'. 'data-shown-when' accepts the name of the element to be observed, not the id. Observed values for 'data-shown-when-value' are in the form
                  of a stringified array (e.g., "['Hello',"0"]")
                </p>
                <pre>
&lt;form class=&quot;form-horizontal&quot; role=&quot;form&quot;&gt;
  &lt;div class=&quot;form-group&quot;&gt;
    &lt;label for=&quot;category&quot; class=&quot;control-label&quot;&gt;Category&lt;/label&gt;
    &lt;div class=&quot;col-sm-6&quot;&gt;
      &lt;select type=&quot;text&quot; id=&quot;category&quot; class=&quot;form-control&quot; name=&quot;category&quot;&gt;
        &lt;option value=&quot;&quot;&gt;Select category&lt;/option&gt;
        &lt;option value=&quot;Animal&quot;&gt;Animal&lt;/option&gt;
        &lt;option value=&quot;Plant&quot;&gt;Plant&lt;/option&gt;
        &lt;option value=&quot;Thing&quot;&gt;Thing&lt;/option&gt;
        &lt;option value=&quot;Other&quot;&gt;Other&lt;/option&gt;
      &lt;/select&gt;
    &lt;/div&gt;
  &lt;/div&gt;
  &lt;div class=&quot;form-group&quot;&gt;
    &lt;label for=&quot;other_category&quot; class=&quot;control-label&quot;&gt;&lt;/label&gt;
    &lt;div class=&quot;col-sm-6&quot;&gt;
      &lt;input type=&quot;text&quot; id=&quot;other_category&quot; class=&quot;form-control&quot; name=&quot;other_category&quot; value=&quot;&quot; placeholder=&quot;Specify category&quot; data-show-when=&quot;category&quot; data-show-when-value=&quot;['Other']&quot; /&gt;
    &lt;/div&gt;
  &lt;/div&gt;
  &lt;div class=&quot;form-group&quot;&gt;
    &lt;label for=&quot;meow&quot; class=&quot;control-label&quot;&gt;Does it say meow?&lt;/label&gt;
    &lt;div class=&quot;col-sm-6&quot;&gt;
      &lt;div class=&quot;col-sm-1&quot;&gt;
        <span>The input field below has: 
          data-show-when=&quot;category&quot;                  (provide name of reference field)
          data-show-when-value=&quot;['Animal','Other']&quot;  (provide a stringified array of values)
        There is also a data-show-when-value-not attribute that does the opposite.</span>
        &lt;input id=&quot;meow_true&quot; name=&quot;meow&quot; class=&quot;form-control&quot; type=&quot;radio&quot; value=&quot;true&quot; data-show-when=&quot;category&quot; data-show-when-value=&quot;['Animal','Other']&quot; /&gt;
      &lt;/div&gt;
      &lt;div class=&quot;col-sm-3&quot;&gt;
        &lt;label for=&quot;meow_true&quot; class=&quot;control-label&quot;&gt;Yes&lt;/label&gt;
      &lt;/div&gt;
      &lt;div class=&quot;col-sm-1&quot;&gt;
        &lt;input id=&quot;meow_false&quot; name=&quot;meow&quot; class=&quot;form-control&quot; type=&quot;radio&quot; value=&quot;false&quot; /&gt;
      &lt;/div&gt;
      &lt;div class=&quot;col-sm-3&quot;&gt;
        &lt;label for=&quot;meow_false&quot; class=&quot;control-label&quot;&gt;No&lt;/label&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/div&gt;
  &lt;div class=&quot;form-group&quot;&gt;
    &lt;label for=&quot;sunlight&quot; class=&quot;control-label&quot;&gt;Does it need alot of sunlight?&lt;/label&gt;
    &lt;div class=&quot;col-sm-6&quot;&gt;
      &lt;div class=&quot;col-sm-1&quot;&gt;
        &lt;input id=&quot;sunlight_true&quot; name=&quot;sunlight&quot; class=&quot;form-control&quot; type=&quot;radio&quot; value=&quot;true&quot; data-show-when=&quot;category&quot; data-show-when-value=&quot;['Plant','Other']&quot; /&gt;
      &lt;/div&gt;
      &lt;div class=&quot;col-sm-3&quot;&gt;
        &lt;label for=&quot;sunlight_true&quot; class=&quot;control-label&quot;&gt;Yes&lt;/label&gt;
      &lt;/div&gt;
      &lt;div class=&quot;col-sm-1&quot;&gt;
        &lt;input id=&quot;sunlight_false&quot; name=&quot;sunlight&quot; class=&quot;form-control&quot; type=&quot;radio&quot; value=&quot;false&quot; /&gt;
      &lt;/div&gt;
      &lt;div class=&quot;col-sm-3&quot;&gt;
        &lt;label for=&quot;sunlight_false&quot; class=&quot;control-label&quot;&gt;No&lt;/label&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/div&gt;
  &lt;div class=&quot;form-group&quot;&gt;
    &lt;label for=&quot;vine&quot; class=&quot;control-label&quot;&gt;Is it a vine?&lt;/label&gt;
    &lt;div class=&quot;col-sm-6&quot;&gt;
      &lt;div class=&quot;col-sm-1&quot;&gt;
        &lt;input id=&quot;vine_true&quot; name=&quot;vine&quot; class=&quot;form-control&quot; type=&quot;radio&quot; value=&quot;true&quot; data-show-when=&quot;category&quot; data-show-when-value=&quot;['Plant','Other']&quot; /&gt;
      &lt;/div&gt;
      &lt;div class=&quot;col-sm-3&quot;&gt;
        &lt;label for=&quot;vine_true&quot; class=&quot;control-label&quot;&gt;Yes&lt;/label&gt;
      &lt;/div&gt;
      &lt;div class=&quot;col-sm-1&quot;&gt;
        &lt;input id=&quot;vine_false&quot; name=&quot;vine&quot; class=&quot;form-control&quot; type=&quot;radio&quot; value=&quot;false&quot; /&gt;
      &lt;/div&gt;
      &lt;div class=&quot;col-sm-3&quot;&gt;
        &lt;label for=&quot;vine_false&quot; class=&quot;control-label&quot;&gt;No&lt;/label&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/div&gt;
  &lt;div class=&quot;form-group&quot;&gt;
    &lt;label for=&quot;soft&quot; class=&quot;control-label&quot;&gt;Is it soft?&lt;/label&gt;
    &lt;div class=&quot;col-sm-6&quot;&gt;
      &lt;div class=&quot;col-sm-1&quot;&gt;
        &lt;input id=&quot;soft_true&quot; name=&quot;soft&quot; class=&quot;form-control&quot; type=&quot;radio&quot; value=&quot;true&quot; data-show-when=&quot;category&quot; data-show-when-value=&quot;['Thing','Other']&quot; /&gt;
      &lt;/div&gt;
      &lt;div class=&quot;col-sm-3&quot;&gt;
        &lt;label for=&quot;soft_true&quot; class=&quot;control-label&quot;&gt;Yes&lt;/label&gt;
      &lt;/div&gt;
      &lt;div class=&quot;col-sm-1&quot;&gt;
        &lt;input id=&quot;soft_false&quot; name=&quot;soft&quot; class=&quot;form-control&quot; type=&quot;radio&quot; value=&quot;false&quot; /&gt;
      &lt;/div&gt;
      &lt;div class=&quot;col-sm-3&quot;&gt;
        &lt;label for=&quot;soft_false&quot; class=&quot;control-label&quot;&gt;No&lt;/label&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/div&gt;
  &lt;div class=&quot;form-group form-buttons&quot;&gt;
    &lt;button type=&quot;submit&quot; class=&quot;btn btn-primary&quot;&gt;Submit&lt;/button&gt;
    &lt;button type=&quot;button&quot; class=&quot;btn&quot;&gt;Cancel&lt;/button&gt;
  &lt;/div&gt;
&lt;/form&gt;
                </pre>
              </div>
              <div class="tab-pane fade" id="tab_3">
                <h3>Dynamically add fields</h3>
                <p>You can dynamically add multiple fields or groups of fields. The default behavior is to keep one group always available for input entry.
                So if you remove the last multi-field group, it will spawn a new blank group automatically. The default maximum
                number of multi-field groups is 3. This can be increased by customizing data-multi-field-max. The form below has been customized
                to have a maximum of 5. The add button automatically appears or disappears depending if max fields has been reached.</p>
                <form class="form-horizontal" role="form">
                  <div class="multi-field">
                    <div class="multi-field-item multi-field-template" data-multi-field-max="5" data-multi-field-preload='true'>
                      <div class="form-group">
                        <label for="username" class="control-label">Name</label>
                        <div class="col-sm-4">
                          <input type="text" id="username" class="form-control" name="customer[][username]" value="" placeholder="Name" />
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="number" class="control-label">Mobile number</label>
                        <div class="col-sm-4">
                          <input type="text" id="number" class="form-control" name="customer[][number]" value="" placeholder="Phone number" />
                        </div>
                      </div>
                      <div class="form-group form-buttons">
                        <button type="button" class="btn btn-danger multi-field-btn-delete"><span class="fa fa-minus"></span> Remove</button>
                      </div>
                    </div>
                    <div class="form-group form-buttons">
                      <button type="button" class="btn btn-primary multi-field-btn-add"><span class="fa fa-plus"></span> Add more</button>
                    </div>
                  </div>
                </form>
                <p>If data is to be pre-loaded with the multi-field, just insert multi-field-item
                  inside the multi-field to have it considered for counting for max-field. Use data-multi-field-preload='true'
                  if you want to have the form create a new instance automatically on page load.</p>
                <pre>
&lt;form class=&quot;form-horizontal&quot; role=&quot;form&quot;&gt;
  <span>Encapsulate a form group or groups to use for multi-field</span>
  &lt;div class=&quot;multi-field&quot;&gt;
    <span>Each item group is enclosed in multi-field. Optional attributes are:
      data-multi-field-max='5'          (for limiting item instances, where '5' is your maximum field limit)
      data-multi-field-preload='true'   (for creating a blank item on load automatically)</span>
    &lt;div class=&quot;multi-field-item multi-field-template&quot; data-multi-field-max=&quot;5&quot; data-multi-field-preload=&quot;true&quot;&gt;
      &lt;div class=&quot;form-group&quot;&gt;
        &lt;label for=&quot;username&quot; class=&quot;control-label&quot;&gt;Name&lt;/label&gt;
        &lt;div class=&quot;col-sm-4&quot;&gt;
          &lt;input type=&quot;text&quot; id=&quot;username&quot; class=&quot;form-control&quot; name=&quot;customer[][username]&quot; value=&quot;&quot; placeholder=&quot;Name&quot; /&gt;
        &lt;/div&gt;
      &lt;/div&gt;
      &lt;div class=&quot;form-group&quot;&gt;
        &lt;label for=&quot;number&quot; class=&quot;control-label&quot;&gt;Mobile number&lt;/label&gt;
        &lt;div class=&quot;col-sm-4&quot;&gt;
          &lt;input type=&quot;text&quot; id=&quot;number&quot; class=&quot;form-control&quot; name=&quot;customer[][number]&quot; value=&quot;&quot; placeholder=&quot;Phone number&quot; /&gt;
        &lt;/div&gt;
      &lt;/div&gt;
      <span>Unlike tabs, the delete button is not created automatically. This is to give you full
        control on positioning and layout of the button. Use the class .multi-field-btn-delete to
        tag the button as a delete button for the group. Use class .btn-danger to color it red.</span>
      &lt;div class=&quot;form-group form-buttons&quot;&gt;
        &lt;button type=&quot;button&quot; class=&quot;btn btn-danger multi-field-btn-delete&quot;&gt;&lt;span class=&quot;fa fa-minus&quot;&gt;&lt;/span&gt; Remove&lt;/button&gt;
      &lt;/div&gt;
    &lt;/div&gt;
    &lt;div class=&quot;form-group form-buttons&quot;&gt;
      <span>Create the add button manually, use .multi-field-btn-add</span>
      &lt;button type=&quot;button&quot; class=&quot;btn btn-primary multi-field-btn-add&quot;&gt;&lt;span class=&quot;fa fa-plus&quot;&gt;&lt;/span&gt; Add more&lt;/button&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/form&gt;
                </pre>
              </div>
              <div class="tab-pane fade" id="tab_4">
                <h3>Form Validators and Maskers</h3>
                <p>Below are examples of validators and maskers available. The masker is 
                combined with the validator for certain data types like phone, email and decimals.
                You can only combine the class 'required' with all other validator classes,
                but you cannot combine data type validators with each other. the attribute data-length-max
                ensures length of fields for both inputs and textareas.</p>
                <form class="form-horizontal" role="form">
                  <div class="form-group">
                    <label for="valid-username" class="control-label">Name</label>
                    <div class="col-sm-8">
                      <input type="text" id="valid-username" class="form-control required" name="customer[][username]" value="" placeholder="Name (class='required')" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="type" class="control-label">Type</label>
                    <div class="col-sm-6">
                      <div class="col-sm-1">
                        <input type="radio" id="type_customer" class="form-control required" name="customer[][type]" value="customer" />
                      </div>
                      <div class="col-sm-3">
                        <label for="type_customer" class="control-label">Customer</label>
                      </div>
                      <div class="col-sm-1">
                        <input type="radio" id="type_employee" class="form-control" name="customer[][type]" value="employee" />
                      </div>
                      <div class="col-sm-3">
                        <label for="type_employee" class="control-label">Employee</label>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="assets-integer" class="control-label">Assets</label>
                    <div class="col-sm-4 input-group">
                      <div class="input-group-addon">&#8369;</div>
                      <input type="text" id="assets-integer" class="form-control integer positive" name="customer[][assets-integer]" value="" placeholder="Assets (class='integer-positive')" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="debt-integer" class="control-label">Liabilities</label>
                    <div class="col-sm-4 input-group">
                      <div class="input-group-addon">&#8369;</div>
                      <input type="text" id="debt-integer" class="form-control integer negative" name="customer[][debt-integer]" value="" placeholder="Debt (class='integer-negative')" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="worth-integer" class="control-label">Net Worth</label>
                    <div class="col-sm-4 input-group">
                      <div class="input-group-addon">&#8369;</div>
                      <input type="text" id="worth-integer" class="form-control integer" name="customer[][worth-integer]" value="" placeholder="Net worth (class='integer')" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="assets-decimal" class="control-label">Assets</label>
                    <div class="col-sm-4 input-group">
                      <div class="input-group-addon">&#8369;</div>
                      <input type="text" id="assets-decimal" class="form-control decimal positive" name="customer[][assets-decimal]" value="" placeholder="Assets (class='decimal-positive')" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="liabilities-decimal" class="control-label">Liabilities</label>
                    <div class="col-sm-4 input-group">
                      <div class="input-group-addon">&#8369;</div>
                      <input type="text" id="liabilities-decimal" class="form-control decimal negative" name="customer[][liabilities-decimal]" value="" placeholder="Debt (class='decimal-negative')" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="networth-decimal" class="control-label">Net Worth</label>
                    <div class="col-sm-4 input-group">
                      <div class="input-group-addon">&#8369;</div>
                      <input type="text" id="networth-decimal" class="form-control decimal" name="customer[][networth-decimal]" value="" placeholder="Net worth (class='decimal')" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="email" class="control-label">Email</label>
                    <div class="col-sm-6">
                      <input type="text" id="email" class="form-control email" name="customer[][email]" value="" placeholder="Email (class='email')" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="valid-number" class="control-label">Phone Number</label>
                    <div class="col-sm-4">
                      <input type="text" id="valid-number" class="form-control phone" name="customer[][number]" value="" placeholder="Phone number (class='phone')" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="passport" class="control-label">Passport Number</label>
                    <div class="col-sm-4">
                      <input type="text" id="passport" class="form-control alphanumeric" name="customer[][passport]" value="" placeholder="Passport (class='alphanumeric')" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="card-name" class="control-label">Name on Card</label>
                    <div class="col-sm-5">
                      <input type="text" id="card-name" class="form-control alpha" name="customer[][card-name]" value="" placeholder="Name on Card (class='alpha')" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="rate" class="control-label">Interest Rate</label>
                    <div class="col-sm-4 input-group">
                      <input type="text" id="rate" class="form-control rate" name="customer[][rate]" value="" placeholder="Interest rate (class='rate')" />
                      <div class="input-group-addon">%</div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="date" class="control-label">Date</label>
                    <div class="col-sm-4">
                      <input type="text" id="date" class="form-control date" name="customer[][date]" value="" placeholder="Date (class='date')" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="notes" class="control-label">Notes</label>
                    <div class="col-sm-7">
                      <textarea id="notes" class="form-control" name="customer[][notes]" placeholder="Notes (data-length-max='50')" rows='5' data-length-max='50'></textarea>
                    </div>
                  </div>
                </form>
              </div>


              <div class="tab-pane fade" id="tab_5">
                <h3>Theme changer</h3>
                <p>fourth Tab</p>
              </div>


              <div class="tab-pane fade" id="tab_6">
                <h3>How to present data in a table</h3>

                <g:form class="form-inline">
                  <div class="form-group">
                      <g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
                  </div>
                  <div class="right">
                  <div class="form-group">
                      <g:textField  type="text" name="query" class="form-control input-sm pull-right" style="width: 150px;" placeholder="Search"/>
                  </div>
                  <g:submitButton name="Search" class="btn btn-sm btn-default"><i class="fa fa-search"></i></g:submitButton>
                </div>
              </g:form>

                <table class="table table-bordered table-rounded table-striped table-hover">
                  <thead>
                    <tr>
                      <th class="sortable"><a href="#">Lorem ipsum</a></th>
                      <th><a href="#">Lorem ipsum</a></th>
                      <th>Lorem ipsum</th>
                      <th><a href="#">Lorem ipsum</a></th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>Lorem ipsum</td>
                      <td>Lorem ipsum</td>
                      <td>Lorem ipsum</td>
                      <td>Lorem ipsum</td>
                    </tr>
                    <tr>
                      <td>Lorem ipsum</td>
                      <td>Lorem ipsum</td>
                      <td>Lorem ipsum</td>
                      <td>Lorem ipsum</td>
                    </tr>
                    <tr>
                      <td>Lorem ipsum</td>
                      <td>Lorem ipsum</td>
                      <td>Lorem ipsum</td>
                      <td>Lorem ipsum</td>
                    </tr>
                    <tr>
                      <td>Lorem ipsum</td>
                      <td>Lorem ipsum</td>
                      <td>Lorem ipsum</td>
                      <td>Lorem ipsum</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              
              <div class="tab-pane fade" id="tab_9">
                <h3>Alerts and Messages</h3>
                
                <div class="alert alert-danger" role="alert">
                  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                  <span class="sr-only">Error:</span>
                  Enter a valid email address
                </div>

                <div class="alert alert-info" role="alert">
                  <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
                  <span class="sr-only">Note:</span>
                  These are the times that try men's souls: The summer soldier and the sunshine patriot will, in this crisis, shrink from the service of his country.
                </div>

                <div class="alert alert-success" role="alert">
                  <span class="glyphicon glyphicon-ok-circle" aria-hidden="true"></span>
                  <span class="sr-only">Success</span>
                  Though the truth may vary, this ship will carry our bodies safe to shore.
                </div>

              </div>

              <div class="tab-pane fade" id="tab_7">
                <h3>Form Components</h3>
                <p>Below are examples of form elements and their behaviors:</p>
                <form class="form-horizontal" role="form">
                  <p>All select fields automatically get a search filter. No need to change code.</p>
                  <div class="form-group">
                    <label for="category" class="control-label">Select with filter</label>
                    <div class="col-sm-6">
                      <select type="text" id="category" class="form-control" name="category2" placeholder="Select Category">
                        <option></option>
                        <option value="Animal">Animal</option>
                        <option value="Plant">Plant</option>
                        <option value="Thing">Thing</option>
                        <option value="Other">Other</option>
                      </select>
                    </div>
                  </div>
                  <p>If you add the attribute "multiple='multiple'", you automatically get a multi-select filterable list.</p>
                  <div class="form-group">
                    <label for="category" class="control-label">Multi-Select with filter</label>
                    <div class="col-sm-6">
                      <select type="text" id="category" class="form-control" name="category3" multiple="multiple"  placeholder="Select Category">
                        <option></option>
                        <option value="Animal">Animal</option>
                        <option value="Fruit">Fruit</option>
                        <option value="Machine">Machine</option>
                        <option value="Person">Person</option>
                        <option value="Plant">Plant</option>
                        <option value="Toy">Toy</option>
                        <option value="Other">Other</option>
                      </select>
                    </div>
                  </div>
                  <p>Using the g:customDatePicker, you get a datepicker which can be inputted with the date manually, or selected from calendar inline pop-up. This changes the implementation
                  from the old customDatePicker, as the field which were 3 select fields is now compressed to one. The side-effect is that on the backend, you need tweak the handling for the
                  date as now it only returns one variable for date.</p>
                  <div class="form-group">
                    <label for="category" class="control-label">Custom Date Picker</label>
                    <div class="col-sm-6">
                      <g:customDatePicker name="openDate" class="form-control" value="" placeholder="Enter or Select Date (mm/dd/yyyy)" />
                    </div>
                  </div>
                </form>
              </div>

              <div class="tab-pane fade" id="tab_10">
                <h3>Editable Grid</h3>

                Include the script <code>editablegrid-2.0.1.js</code> and the stylesheet <code>editablegrid-2.0.1.css</code>.
                <p>
                Complete documentation is available at: <a href="http://www.editablegrid.net/">http://www.editablegrid.net/</a>.</p>

                Sample code (load table data through JSON file):
                <pre>&lt;div id="tablecontent"&gt;&lt;/div&gt;

&lt;script&gt;
  window.onload = function() {
    editableGrid = new EditableGrid("DemoGridJSON"); 
    editableGrid.tableLoaded = function() { this.renderGrid("tablecontent", "testgrid 
    table table-striped table-rounded"); };
    editableGrid.loadJSON("/icbs-project/assets/grid.json");
  } 
&lt;/script&gt;</pre>
<p>Sample JSON data</p>
<pre>{"metadata":[
  {"name":"name","label":"NAME","datatype":"string","editable":true},
  {"name":"firstname","label":"FIRSTNAME","datatype":"string","editable":true},
  {"name":"age","label":"AGE","datatype":"integer","editable":true},
  {"name":"height","label":"HEIGHT","datatype":"double(m,2)","editable":true},
  {"name":"country","label":"COUNTRY","datatype":"string","editable":true,"values":
    {
      "Europe":{"be":"Belgium","fr":"France","uk":"Great-Britain","nl":"Nederland"},
      "America":{"br":"Brazil","ca":"Canada","us":"USA"},
      "Africa":{"ng":"Nigeria","za":"South-Africa","zw":"Zimbabwe"}}
    },
  {"name":"email","label":"EMAIL","datatype":"email","editable":true},
  {"name":"freelance","label":"FREELANCE","datatype":"boolean","editable":true},
  {"name":"lastvisit","label":"LAST VISIT","datatype":"date","editable":true}
],

"data":[
  {"id":1, "values":{"country":"uk","age":33,"name":"Duke","firstname":"Patience","height":1.842,"email":"patience.duke@gmail.com","lastvisit":"11\/12\/2002"}},
  {"id":2, "values":["Rogers","Denise",59,1.627,"us","rogers.d@gmail.com","","07\/05\/2003"]},
  {"id":3, "values":{"name":"Dujardin","firstname":"Antoine","age":21,"height":1.73,"country":"fr","email":"felix.compton@yahoo.fr","freelance":true,"lastvisit":"21\/02\/1999"}},
  {"id":4, "values":{"name":"Conway","firstname":"Coby","age":47,"height":1.96,"country":"za","email":"coby@conwayinc.com","freelance":true,"lastvisit":"01\/12\/2007"}},
  {"id":5, "values":{"name":"Shannon","firstname":"Rana","age":24,"height":1.56,"country":"nl","email":"ranna.shannon@hotmail.com","freelance":false,"lastvisit":"07\/10\/2009"}}
]}</pre>

                <div id="tablecontent"></div>

                <script>
                window.onload = function() {
                  editableGrid = new EditableGrid("DemoGridJSON"); 
                  editableGrid.tableLoaded = function() { this.renderGrid("tablecontent", "testgrid table table-striped table-rounded"); };
                  editableGrid.loadJSON("/icbs-project/assets/grid.json");
                } 
              </script>
              </div>

              <div class="tab-pane fade in active" id="tab_8">
                <h3>How to implement tabs</h3>
                <p>Showing content in tabs require 2 parts: the div for class .nav-tab-container and the div for class .tab-content</p>
                <p>The .nav-tab-container contains the code for the tabs:</p>
                <pre>
<span>The line below is the container for your tabs. It handles positioning and contains scrolling.</span>
&lt;div class=&quot;nav-tab-container&quot;&gt;
  <span>The line below is the list containing your tabs:</span>
  &lt;ul class=&quot;nav nav-tabs&quot;&gt;
    <span>The first, or default active tab should have the class 'active'</span>
    &lt;li class=&quot;active&quot;&gt;&lt;a href=&quot;#tab_1&quot; data-toggle=&quot;tab&quot;&gt;Form&lt;/a&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href=&quot;#tab_2&quot; data-toggle=&quot;tab&quot;&gt;Hide/Show content&lt;/a&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href=&quot;#tab_3&quot; data-toggle=&quot;tab&quot;&gt;Dynamically add fields&lt;/a&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href=&quot;#tab_4&quot; data-toggle=&quot;tab&quot;&gt;Form Validations&lt;/a&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href=&quot;#tab_5&quot; data-toggle=&quot;tab&quot;&gt;Maskers&lt;/a&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href=&quot;#tab_6&quot; data-toggle=&quot;tab&quot;&gt;Theme Changer&lt;/a&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href=&quot;#tab_7&quot; data-toggle=&quot;tab&quot;&gt;Data in a Table&lt;/a&gt;&lt;/li&gt;
  &lt;/ul&gt;
&lt;/div&gt;
                </pre>
                <p>You don't need to implement the chevron left and right scroll buttons you see at the tab navigation.
                This is automatically generated when you create a div for the tab container.</p>
                <p>The .tab-content contains the content panes of the tabs:</p>
                <pre>
&lt;div class=&quot;tab-content&quot;&gt;
  <span>Each tab in the .nav-tabs should have a corresponding .tab-pane
  The id is the href reference of the tab.
  The first or default tab pane should have the additional class "active fade in"</span>
  &lt;div class=&quot;tab-pane active fade in&quot; id=&quot;tab_1&quot;&gt;
    &lt;h3&gt;Sample Form&lt;/h3&gt;
    &lt;form class=&quot;form-horizontal&quot; role=&quot;form&quot;&gt;
      &lt;div class=&quot;form-group&quot;&gt;
        &lt;label for=&quot;username&quot; class=&quot;control-label&quot;&gt;Username&lt;/label&gt;
        &lt;div class=&quot;col-sm-4&quot;&gt;
          &lt;input type=&quot;text&quot; id=&quot;username&quot; class=&quot;form-control&quot; name=&quot;username&quot; value=&quot;&quot; placeholder=&quot;Username (case sensitive)&quot; /&gt;
        &lt;/div&gt;
      &lt;/div&gt;
      &lt;div class=&quot;form-group&quot;&gt;
        &lt;label for=&quot;password&quot; class=&quot;control-label&quot;&gt;Password&lt;/label&gt;
        &lt;div class=&quot;col-sm-4&quot;&gt;
          &lt;input type=&quot;password&quot; id=&quot;password&quot; class=&quot;form-control&quot; name=&quot;password&quot; value=&quot;&quot; placeholder=&quot;Password (case sensitive)&quot; /&gt;
        &lt;/div&gt;
      &lt;/div&gt;
      &lt;div class=&quot;form-group form-buttons&quot;&gt;
        &lt;button type=&quot;submit&quot; class=&quot;btn btn-primary&quot;&gt;Submit&lt;/button&gt;
        &lt;button type=&quot;button&quot; class=&quot;btn&quot;&gt;Cancel&lt;/button&gt;
      &lt;/div&gt;
    &lt;/form&gt;
  &lt;/div&gt;
&lt;/div&gt;
                </pre>
              </div>
            </div>
          </div>
        </div>
      </div>
    </content>
  </body>
</html>
