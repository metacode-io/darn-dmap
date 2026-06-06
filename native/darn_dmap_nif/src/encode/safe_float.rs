use rustler::{Decoder, Encoder, Env, Error, Term};

#[derive(Debug, Clone, Copy)]
pub enum NifSafeFloat<T> {
    Finite(T),
    Nil,
}

impl From<f32> for NifSafeFloat<f32> {
    fn from(value: f32) -> Self {
        if value.is_finite() {
            Self::Finite(value)
        } else {
            Self::Nil
        }
    }
}

impl From<f64> for NifSafeFloat<f64> {
    fn from(value: f64) -> Self {
        if value.is_finite() {
            Self::Finite(value)
        } else {
            Self::Nil
        }
    }
}

impl Encoder for NifSafeFloat<f32> {
    fn encode<'a>(&self, env: Env<'a>) -> Term<'a> {
        match self {
            Self::Finite(x) => x.encode(env),
            Self::Nil => None::<f32>.encode(env),
        }
    }
}

impl Encoder for NifSafeFloat<f64> {
    fn encode<'a>(&self, env: Env<'a>) -> Term<'a> {
        match self {
            Self::Finite(x) => x.encode(env),
            Self::Nil => None::<f64>.encode(env),
        }
    }
}

impl<'a> Decoder<'a> for NifSafeFloat<f32> {
    fn decode(term: Term<'a>) -> Result<Self, Error> {
        let value: Option<f32> = term.decode()?;

        Ok(match value {
            Some(x) => Self::from(x),
            None => Self::Nil
        })
    }
}

impl<'a> Decoder<'a> for NifSafeFloat<f64> {
    fn decode(term: Term<'a>) -> Result<Self, Error> {
        let value: Option<f64> = term.decode()?;

        Ok(match value {
            Some(x) => Self::from(x),
            None => Self::Nil,
        })
    }
}