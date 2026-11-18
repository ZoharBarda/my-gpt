"""All communication with OpenAI. Runs on the server only."""
import logging

from openai import (
    APIConnectionError,
    APIStatusError,
    APITimeoutError,
    AuthenticationError,
    OpenAI,
    RateLimitError,
)

from config import OPENAI_API_KEY, OPENAI_MODEL, OPENAI_TIMEOUT_SECONDS
from services.errors import AppError

logger = logging.getLogger(__name__)

SYSTEM_PROMPT = (
    "You are a helpful, friendly assistant. "
    "Answer in the same language the user writes in."
)

_client: OpenAI | None = None


def _get_client() -> OpenAI:
    global _client
    if not OPENAI_API_KEY:
        raise AppError(500, "The chat service is not configured. Please contact the administrator.")
    if _client is None:
        _client = OpenAI(api_key=OPENAI_API_KEY, timeout=OPENAI_TIMEOUT_SECONDS, max_retries=1)
    return _client


def generate_reply(history: list[dict[str, str]]) -> str:
    """Send the full conversation history to OpenAI and return the reply text.

    `history` is a list of {"role": "user"|"assistant", "content": str}.
    """
    client = _get_client()
    messages = [{"role": "system", "content": SYSTEM_PROMPT}, *history]
    try:
        response = client.chat.completions.create(model=OPENAI_MODEL, messages=messages)
    except APITimeoutError:
        raise AppError(504, "The chat took too long to respond. Please try again.")
    except RateLimitError:
        raise AppError(429, "The chat is busy right now. Please try again in a moment.")
    except AuthenticationError:
        logger.error("OpenAI rejected the API key")
        raise AppError(500, "The chat service is not configured correctly. Please contact the administrator.")
    except (APIConnectionError, APIStatusError):
        logger.exception("OpenAI request failed")
        raise AppError(502, "The chat service is unavailable right now. Please try again later.")

    reply = (response.choices[0].message.content or "").strip()
    if not reply:
        raise AppError(502, "The chat returned an empty answer. Please try again.")
    return reply
