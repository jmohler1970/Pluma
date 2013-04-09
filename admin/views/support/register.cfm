<!---
Copyright (C) 2012 James Mohler

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--->



<div class="main">

<h3>Register Your Site</h3>


<cfoutput>
<form method="post" class="anondata" action="#buildURL(action = '.preview')#">
</cfoutput>		
		 
<p>Web World Inc needs to find out what type of people and businesses are using our product. This form allows you to voluntarily send us <u>completely
				anonymous data</u> about your website. This data includes things like the type of server you're on, your ColdFusion version and how many pages and files you currently have.
				We would be very grateful if you could take a few minutes to submit this data to us as it is essential for the continued growth of 
				our CMS product. There is no automatic upload of any data unless you actively send it by clicking '<b>Send Data</b>'.</p>

<p>Complete the optional fields below, then click the '<b>Preview Data Submission</b>' button to preview your data before it's sent to our servers.</p>
<p class="clearfix"><label>Website Category:</label>
		<select name="category" class="text">
			<option value=""></option>
			<option value="Arts">Arts</option>
			<option value="Business">Business</option>
			<option value="Children">Children</option>
			<option value="Computer &amp; Internet">Computer &amp; Internet</option>
			<option value="Culture &amp; Religion">Culture &amp; Religion</option>
			<option value="Education">Education</option>
			<option value="Employment">Employment</option>
			<option value="Entertainment">Entertainment</option>
			<option value="Money &amp; Finance">Money &amp; Finance</option>
			<option value="Food">Food</option>
			<option value="Games">Games</option>
			<option value="Government">Government</option>
			<option value="Health &amp; Fitness">Health &amp; Fitness</option>
			<option value="HighTech">HighTech</option>
			<option value="Hobbies &amp; Interests">Hobbies &amp; Interests</option>
			<option value="Law">Law</option>
			<option value="Life Family Issues">Life Family Issues</option>
			<option value="Marketing">Marketing</option>
			<option value="Media">Media</option>
			<option value="Misc">Misc</option>
			<option value="Movies &amp; Television">Movies &amp; Television</option>
			<option value="Music &amp; Radio">Music &amp; Radio</option>
			<option value="Nature">Nature</option>
			<option value="Non-Profit">Non-Profit</option>
			<option value="Personal Homepages">Personal Homepages</option>
			<option value="Pets">Pets</option>
			<option value="Home &amp; Garden">Home &amp; Garden</option>
			<option value="Real Estate">Real Estate</option>
			<option value="Science &amp; Technology">Science &amp; Technology</option>
			<option value="Shopping &amp; Services">Shopping &amp; Services</option>
			<option value="Society">Society</option>
			<option value="Sports">Sports</option>
			<option value="Tourism">Tourism</option>
			<option value="Transportation">Transportation</option>
			<option value="Travel">Travel</option>
			<option value="X-rated">X-rated</option>
		</select>
</p>

<p class="clearfix"><label>Do you link back to Web World Inc?</label>
<select class="text" name="link_back">
	<option></option>
	<option value="yes">Yes</option>
	<option value="no">No</option>
</select>
</p>

<p class="clearfix"><label>Contact Email For Support</label>
<input type="text" name="email" class="text">

</p>



<p class="submit"><br>
	<input type="submit" class="submit" value="Preview Data Submission" name="preview" />
</p>


	
		</form>

</div>