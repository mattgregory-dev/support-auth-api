# support-auth-api

This project is the backend API responsible for login state, permissions, and access decisions for a web application.

From a support perspective, this is the part of the system that determines whether a user is logged in, which account they are using, and what actions are allowed. The frontend makes requests; this API decides whether those requests succeed or fail.

## What This API Does

This API handles:

- Logging users in and out
- Tracking whether a user is currently logged in
- Determining access based on the user’s account and role
- Rejecting requests when a user is not logged in or not permitted

If the UI appears correct but actions fail, the cause is often here.

## Issues This API Helps Explain

This API is central to diagnosing common customer-reported problems, including:

- A user can log in but cannot complete an action
- A user is logged out unexpectedly
- One user can access something another user cannot
- The UI shows the user as logged in, but requests fail
- Logging out and back in temporarily resolves the issue

These cases usually relate to session state, authentication, or permissions enforced by the API.

## Authentication and Session Behavior

This API uses login sessions to track whether a user is authenticated.

- When a user logs in successfully, a session is created
- That session is stored using cookies
- Every request checks whether a valid session exists
- If the session is missing, expired, or invalid, the user is treated as logged out

From a support perspective, this means:
- A user may appear logged in on the screen but still fail actions if the session is no longer valid
- Logging out and logging back in often resets session-related issues
- Session problems commonly explain “it worked earlier but not now”

## User Roles and Permissions

Each user account has a role assigned by the system.

Roles include:
- Consumer
- Partner
- Admin

The role determines what actions the API allows the user to perform.

Important points for support:
- Roles are enforced by the API, not the UI
- The frontend cannot override permissions
- If a user believes they should have access, the role assigned to their account must be verified

If access is denied, it is usually because:
- The user is not logged in
- The session is invalid
- The user’s role does not permit the action

## Common API Responses and What They Mean

Support frequently encounters these responses:

- **200 OK**
  The request succeeded. The user is logged in and allowed to perform the action.
- **401 Unauthorized**  
  The user is not logged in or the session is invalid.  
  Commonly resolved by logging in again.
- **403 Forbidden**  
  The user is logged in, but their role does not allow the action.  
  This is usually a permissions or account-type issue, not a login problem.

Understanding these responses helps determine whether an issue is related to login state, account permissions, or something else.

## Common Support Checks (API Side)

When investigating an issue, common things to verify on the API side include:

- Is the user currently logged in?
- Does the session still exist and appear valid?
- Does the `/me` endpoint return a user or an error?
- Is the user assigned the correct role?
- Is the API returning a 401 (not logged in) or 403 (not allowed)?

These checks help determine whether the problem is related to login state, permissions, or something outside the API.

## Relationship to the Frontend Application

This API is used by a separate frontend application that users interact with directly.

The frontend:
- Sends login and logout requests
- Asks the API who the current user is
- Displays or hides features based on API responses

The API:
- Decides whether a user is logged in
- Decides whether an action is allowed
- Rejects requests when conditions are not met

If the frontend and API disagree about a user’s state, the API response should be treated as the source of truth.

## Status and Intent

This project exists to simulate real-world authentication, session, and permission issues that commonly surface in customer support tickets.

It is intentionally focused on:
- Login and logout behavior
- Session-related problems
- Role-based access decisions
- Clear failure cases that require explanation or escalation

The goal is not feature completeness, but realism from a support and troubleshooting perspective.