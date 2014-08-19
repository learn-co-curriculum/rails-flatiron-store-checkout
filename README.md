---
tags: full-application, associations, stripe, intermediate, WIP
language: ruby
resources: 2
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

## Up Next: Third iteration

1. Segment.io analysis of user events / behavior

## Resources
* [Setting up Stripe on Rails](https://stripe.com/docs/checkout/guides/rails)
* [Strip Checkout documentation](https://stripe.com/docs/checkout)