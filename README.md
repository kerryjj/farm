# Farm

Shows quickly how I tend to setup bounded contexts in elixir/phoenix with complex data access.
Once the queries and database access become more than just CRUD I create a repo dedicated to the database access for this bounded context.

There are a couple of principles that I currently keep in mind and these drive me to a structure like this. 
These principles are:
* Changesets and modules that contain DB schema (model) definitions should not contain any business logic
* Validation of user inputs should happen as close to the edge as possible. 
  * That often means user input validation is done in a controller or plug and not left for the changeset to sort out.  

To run tests
`mix test`

I'd definitely like feedback on this as a general approach.

If you have any comments/feedback please leave them with this repo. Or submit a PR with your suggestions as code :)