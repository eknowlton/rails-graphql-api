# README

## Developer Setup

- Clone repository
- Ensure ruby version is set to version in `.ruby-version` file

In your terminal:

```shell
$ git clone git@github.com:kimmelsg/central-api.git && cd central-api
$ cat .ruby-version
# Ensure your ruby version matches, use `rbenv` to manage multiple ruby versions
$ ruby bin/development.rb
```

### Authentication

We use token authentication, where a user has a token generated for them. Two tokens are returned on a successful sign in. The access token is used in a traditional way to access all apps within the Kimmel ecosystem. To make authenticated queries add `Authorization` with the access token string to the headers.

Example HTTP Headers
```
Authorization: ccDqq8GpZvkcDLi9eGR6ZNjn
```

GraphQL variables and query for sign in to the test account:

```graphql
mutation ($input: SignInUserInput!) {
  signInUser(input: $input) {
    refreshToken
    accessToken
    user {
      email
    }
    errors {
      field
      message
    }
  }
}

# variables
{
  input: {
    "email": "test@kimmel.com",
    "password": "Tester12"
  }
}
```

The second token type is a refresh token which is used to talk back to central and get new tokens issued when the access token has expired.

Example GraphQL variables and query for refresh token mutation:

```graphql
mutation($input: RefreshTokensInput!) {
  refreshTokens(input: $input) {
    refreshToken
    accessToken
    user {
      email
    }
    errors {
      field
      message
    }
  }
}

# variables
{
  input: {
    "refreshToken": "ccDqq8GpZvkcDLi9eGR6ZNjn"
  }
}
```
