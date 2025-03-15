# README

I'm going to answer to the challenge questions.

## Data model: What data model would best support this application? Can you describe it? Include table specifications (or documents if it's a non-relational database) with fields, their associations, and the meaning of each entity.

From the first read of the problem statement, I can see that the best approach to model the data is to use a relational database.\
I've modeled the data in the following way:
### Categories table:
Each product belongs to a category so the end user can easily find the product they are looking for.

| id | name | description | deleted_at |
|----|------|-------------|------------|

### Products table:
Each product belongs to a category and has the following columns.

| id | name | description | deleted_at | category_id |
|----|------|-------------|------------|-------------|

the `category_id` column is a foreign key to the `id` column of the `Category` table,
so we can easily access to the products of a category using Rails features.

### Parts table:
Parts are the components of a product. Each product has many parts.
Products and parts have a many-to-many relationship, so we've created a join table `product_parts` to store the relationship between products and parts, I'm going to omit this table for clarity.

| id | name | deleted_at | 
|----|------|------------|

```ruby
# To access to the parts of a product you can:
product = ::Product.first
product.parts
# To access to the products using a specific part you can:
part = ::Part.first
part.products_using_this_part
```

### Part Options table:
Part options are the options of a part. Each part has many part options, so a part option belongs to a part.

| id | name | deleted_at | stock | part_id | price |  
|----|------|------------|-------|---------|-------|
`stock` is a boolean that indicates if the part option is in stock or not; in this way Marcus can track the stock of each part option.
`price` is the base price of the part option and should be greater than 0.

### Price Rules table:
Marcus should be able to custom price rules depending on a specific condition.\
For instance, the frame finish is applied over the whole bicycle, so the more area to cover, the more expensive it gets.
Because of that, the matte finish over a full-suspension frame costs extra money, this table permits to Marcus to set custom price rules over the options. 

| id | price_adjustment | base_option_id | dependent_option_id |  
|----|------------------|----------------|---------------------|

`base_option_id - dependent_option_id` is the pair of options that the price adjustment is applied to.

```ruby
# Access to the price rules of a part option:
option = ::PartOption.first
option.price_rules_as_base # To get the price rules where the option is the base option
option.price_rules_as_dependent # To get the price rules where the option is the dependent option
```

### Restrictions table:
Marcus should be able to set restrictions on the options.\
Some options cannot be selected alongside others, for example, so similar to the price rules, this table permits to Marcus to set restrictions on the options.

| id | dependent_option_id | blocked_option_id |
|----|---------------------|-------------------|

`dependent_option_id - blocked_option_id` is the pair of options that cannot be selected together.

```ruby
option = ::PartOption.first
option.restrictions_as_dependent # To get the restrictions where the option is the dependent option
option.restrictions_as_blocked # To get the restrictions where the option is the blocked option
```

### Permissions table:
Marcus needs a way to manage all the entities of his shop, categories, products, parts, part options, price rules, and restrictions.\
I've created a table that stores the permissions of the users.

Users and permissions have a many-to-many relationship, so we've created a join table `user_permissions` to store the relationship between users and permissions, I'm going to omit this table for clarity.

Also I should add a unique index on this table to ensure that a user can have only one permission.

| id | name |
|----|------|

the `name` column is a string that represents the permission.

```ruby
# You can access to the users  that have a specific permission doing:
permission = ::Permission.first
permission.users_with_permission
```

### Users table:
It is important to have a table to store the users of the application, so we can manage orders and other stuff but also create admin users with the permissions to manage the entities of the shop.

| id | email_address | password_digest |
|----|---------------|-----------------|


```ruby
# You can access to the user permissions doing:
user = ::User.first
user.permissions
```

## 2. Main user actions: Explain the main actions users would take on this e-commerce website in detail.
I thought that we should differentiate between the actions that the end user can take and the actions that the admin user can take.

### Simple user actions:
- The end user can browse the products.
- The end user can filter the products by category, price, newest. **(not implemented in the UI)**
- The end user can see the details of a product by clicking on a specific product.
- The end user can add configure the parts of the product.
- The end user can add the product to the cart. **(not implemented in the UI)**

### Admin user actions:
- All the actions that the simple user can take.
- The admin user can create, update, delete categories.
- The admin user can create, update, delete products.
- The admin user can create, update, delete parts.
- The admin user can create, update, delete part options.
- The admin user can create, update, delete price rules.
- The admin user can create, update, delete restrictions.

All this actions should be protected by permissions, so only the admin users can perform them.\
Also on the frontend side we should have a way to show the settings page depending on the permissions of the user.

## 3. Product page: This is a read operation, performed when displaying a product page for the customer to purchase. How would you present this UI? How would you calculate which options are available? How would you calculate the price depending on the customer's selections?
I've imagined that a product is a simple card with an image, the name and the description of the product.

All the cards are shown in a grid and the bar filter is on the top. In this products page the user should be able to see only products that are **not soft deleted**, if they are soft deleted it means that they no longer exists on the shop.\
The soft deleted approach assure a way to have consistency on the data, I will dive into more details when talking about the "Add to cart" feature.

Each product has parts, and each part has part options.\
When the user clicks on a product card, the user is redirected to the product page (that is a simple modal) where the user can see and choose the parts of the product and the part options of each part.\
The user cannot choose a part option that is not in stock, he still can see the part option but it is disabled.

Every time a user change the option of the parts of a product, I send a query to compute two things:
1. The restrictions of the options selected, if a match exists an error message is shown.
2. The price of the product depending on the part options selected and the extra price rules of the options.

### 4. Add to cart action: Once the customer makes their selection, there should be an "add to cart" button. What happens when the customer clicks this button? What is persisted in the database?
I wasn't able to complete these task in the project but I have a clear idea of how to implement it.

When the user clicks on the "Add to cart" button, a mutation is send to the server to create a new order.
1. First of all a double check on the restrictions of the options would be made to guarantee that the user is not trying to add to the cart a product with incompatible options.\
I will use the same *service** to compute the validation of the product.
2. I should also double check that all the options chosen are in stock.

If **all is good** I can proceed to create the order.

The order is a simple table with the following columns:

| id | user_email | product_id | total_price | created_at | updated_at |
|----|------------|------------|-------------|------------|------------|


The `user_email` column string column that stores the email of the user that created the order, so we can track the orders of a specific user.\
It can be replaced by a `user_id` column that is a foreign key to the `id` column of the `User` table but sometimes the user is not logged in, so we can't have the `user_id` associated.

The `product_id` column is a foreign key to the `id` column of the `Product` table, so we can easily access to the product of the order.\
In case the product has been soft deleted we still can access to the product of the order, that is one of the benefits of having a soft delete approach.

The `total_price` column is a float that stores the total price of the order; the part options prices can increase (always 😩) or decrease (never 😬) the base price of the product, so we should store the total price of the order at that specific time.\
I will use the same **service** to compute the final price of the order so I centralise the logic of the price calculation.

Now, about the part option...
In my opinion I'd create two tables that will be the `order_parts` table and the `order_part_options` table.\
They are going to be useful to track the parts and the part options of the order, so in case the product changes in the future we can still access to the part options of the order.
Maybe I would add also a foreign key to the `parts` and `part_options` tables but they can be null in case someone hard delete a part or a part option.

## Other questions:
The other questions were:
1. Administrative workflows: Describe the main workflows for Marcus to manage his store.
2. New product creation: What information is required to create a new product? How does the database change?
3. Adding a new part choice: How can Marcus introduce a new rim color? Describe the UI and how the database changes.
4. Setting prices: How can Marcus change the price of a specific part or specify particular pricing for combinations of choices? How does the UI and database handle this?

They are more UI questions I think a simple demo of the Marcus shop would be the best way to answer them :)

Please refer to the UI repo to see a small video of how the shop works.

## Other notes:
First of all, I'd like to spend few words on teh technology I choose for the challenge.

I've been working with GraphQL for like 5 years now and I have to admit that the framework is very useful and helps you to cover most of the use cases.\
It give you also the feature that you need to guarantee performant APIs, alongside with Rails you can easily avoid N+1 queries.

Not everything is perfect, the learning curve is a bit steep and sometimes you have to write a lot of boilerplate code to achieve simple things.\
The frontend can rely on libraries too BUT you need time to understand how to use core feature, especially graphql caching.

Again, I want to highlight the importance of the soft delete approach, it is very useful to have a way to track the changes of the data and to have a way to recover the data in case of a mistake.\

Another thing I would add to this project is a way to track the changes of the data, especially who made the change, a PaperTrail gem would be useful to track the changes of the data.

### Final notes:
I know that this project have a lot of missing features, I've tried to cover the most important parts of the project with the time I had.\
I will be happy to discuss the project with you.


