# Single Sign-On (SSO) Integrations Exercise

This exercise demonstrates the integration of Single Sign-On (SSO) with various providers using OmniAuth and Devise for user authentication and authorization.

## Getting Started

Follow these steps to set up and run the project locally.

### Prerequisites

Before you begin, make sure you have the following prerequisites installed:

- Ruby (>= 3.1.2)
- Ruby on Rails (>= Rails 7.0.7.2)
- PostgreSQL (>= 14.0.0)

### Installation

1. Clone the repository:

   ```shell
   git clone git@github.com:manuelxwhite/sso_integrations.git

2. Change to the project directory:

    ```shell
    cd sso_integrations

3. Install the dependencies:

    ```shell
    bundle install

4. Create the database and run the migrations:

    ```shell
    rails db:create
    rails db:migrate

## Environment Variables

To run the project, you need to define environment variables for each SSO provider you intend to use. Create a `.env` file in the project's root directory and add the following variables:

### Google OAuth2

- `GOOGLE_CLIENT_OAUTH2_ID`: Your Google OAuth2 client ID.
- `GOOGLE_CLIENT_OAUTH2_SECRET`: Your Google OAuth2 client secret.

You can obtain these credentials by creating a project in the [Google Developers Console](https://console.developers.google.com/) and configuring OAuth2 credentials.

### Facebook OAuth2

- `FACEBOOK_CLIENT_ID`: Your Facebook OAuth2 client ID.
- `FACEBOOK_CLIENT_SECRET`: Your Facebook OAuth2 client secret.

Obtain these credentials by creating an app in the [Facebook Developer Portal](https://developers.facebook.com/) and configuring OAuth2 credentials.

### Additional Providers

Repeat the above pattern for any additional SSO providers you want to integrate, specifying the corresponding client ID and client secret for each.

Make sure to add these environment variables to your `.env` file, which should not be committed to version control for security reasons. You can use a tool like [dotenv](https://github.com/bkeepers/dotenv) to manage environment variables during development.

Remember to restart your Rails server after adding or modifying environment variables to apply the changes.

### Authentication
This exercise uses OmniAuth and Devise for user authentication. You can sign up and log in using your chosen SSO providers.

### Testing

To run the test suite, run the following command:

```shell
bundle exec rspec
```