---
tags: full-application, stripe, intermediate, WIP
language: ruby
resources: 2
---

# Flatiron Store on Rails

## Second iteration: Checking out with Stripe

## Tasks

### Tapping in to the `checkout` method

Last lab, we built a post request method `checkout` that handles a bunch of our app's functionality: creating a new order from a cart, changing the order status, changing the inventory, and destroying the cart session.

Now, we're going to do a bit more and refactor that `checkout` functionality. Our site needs to accept payments from users.

This will be the new flow of our application:

1. You add items to your cart
2. You click checkout
3. You fill out payment info
4. You submit your payment
5. Confirmation page 

### Using Stripe to Handle Payments

We're going to use Stripe to handle accepting payments. We're going to integrate their API into our application, and with doing so, change the functionality of our app.

### Tasks:

* Our `checkout` method is going to be done away with and instead that functionality will be handled by methods in the Order class and the orders controller.
* The `create` action in the orders controller will be where our Strip functionality is also handled.
* Read the documentation linked below on how Strip can be integrated into a Rails app. It's a simple example which we're going to build off of.
* Create a StripePayment class which will handle working with the Stripe API
* We're going to persist user input via Stripe, so create a migration as well
* A StripePayment belongs to an Order and an Order has_one StripePayment
* 


## Up Next: Third iteration

1. Segment.io analysis of user events / behavior

## Resources
* [Setting up Stripe on Rails](https://stripe.com/docs/checkout/guides/rails)
* [Strip Checkout documentation](https://stripe.com/docs/checkout)