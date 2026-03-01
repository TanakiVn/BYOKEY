//! `OpenAPI` specification aggregation.

use utoipa::OpenApi;
#[derive(OpenApi)]
#[openapi(
    paths(
        crate::status::status_handler,
        crate::accounts::accounts_handler,
        crate::accounts::remove_account_handler,
        crate::accounts::activate_account_handler,
        crate::ratelimits::ratelimits_handler,
    ),
    components(schemas(
        crate::status::StatusResponse,
        crate::status::ServerInfo,
        crate::status::ProviderStatus,
        crate::status::AuthStatus,
        crate::accounts::AccountsResponse,
        crate::accounts::ProviderAccounts,
        crate::accounts::AccountDetail,
        crate::accounts::TokenStateDto,
        crate::ratelimits::RateLimitsResponse,
        crate::ratelimits::ProviderRateLimits,
        crate::ratelimits::AccountRateLimit,
        byokey_types::RateLimitSnapshot,
    )),
    tags((name = "management", description = "Daemon management API"))
)]
pub struct ApiDoc;

/// Returns the `OpenAPI` specification as JSON.
pub async fn openapi_json() -> axum::Json<utoipa::openapi::OpenApi> {
    axum::Json(ApiDoc::openapi())
}
