---
tags: full-application, associations, omniauth, stripe, cron, intermediate
language: ruby
resources: 4
---

# Flatiron Store on Rails

## Second iteration

1. User functionality through OmniAuth 
2. Stripe API integration
3. The act of checking out creates a user and their order (turning the LineItems in carts into an order that belongs to a user)

## Tasks

### Tapping in to the `checkout` method

Last lab, we built a post request method `checkout` that handles a bunch of our app's functionality: creating a new order from a cart, changing the order status, changing the inventory, and destroying the cart session.

Now, before we checkout we're going to do a bit more. Our site needs to accept payments from users. Think of how most e-commerce sites work:

1. You add items to your cart
2. You click checkout
3. You fill out payment info
4. You submit your order
5. Confirmation page

### Using Stripe to Handle Payments

Before our "checkout" was handled by our checkout method on the carts controller. Instead, we're going to hand over that functionality to Stripe, a super simple and secure way to handle credit card payment processes. Follow the steps outlined in the [Stripe documentation](https://stripe.com/docs/checkout/guides/rails) on how to set this up. Be sure to create a Stripe account to get the test keys to include in your `stripe.rb`initializer. Use figaro to hold onto those keys.

After submitting payment from Stripe, we should be redirected to the `checkout` method that handles our order functionality.

### Bonus functionality: Cron Jobs

If a cart is created every time a user adds an item to it, that's a lot of carts. Not every user goes through with an order, so we'll end up having a lot of cart objects clogging our database.

Let's create an automated process that deletes cart objects from the database after a certain time they were created. Automated processes are usually handled by [cron jobs](http://en.wikipedia.org/wiki/Cron). The [Whenever gem](https://github.com/javan/whenever) in Ruby is an easy to use wrapper for cron jobs. We're going to write a Whenever cron job that triggers a task to clean out our database.

1. Follow the Whenever readme on how to write tasks.
2. We want to delete all instances of Cart that are older than a week. Sounds like a class method on Cart. The whenever cron job should trigger that method. Bonus: write an AREL statement that queries for all records older than a week. Hint: use the handy [Chronic gem](https://github.com/mojombo/chronic) to parse that timeframe.

## Up Next: Third iteration

1. Segment.io analysis of user events / behavior

## Resources

* [Whenever gem doumentation](https://github.com/javan/whenever)
* [cron jobs](http://en.wikipedia.org/wiki/Cron)
* [Chronic gem](https://github.com/mojombo/chronic)
* [Setting up Stripe on Rails](https://stripe.com/docs/checkout/guides/rails)
* [Strip Checkout documentation](https://stripe.com/docs/checkout)