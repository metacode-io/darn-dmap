use dmap::{DmapRecord, Record};
use dmap::types::{DmapField, DmapScalar, DmapVec};

use rustler::{Decoder, Encoder, Env, Error, NifResult, NifTaggedEnum, Term};



#[derive(Debug, Clone, Copy)]
enum NifSafeFloat<T> {
    Finite(T),
    Nil,
}


#[derive(Debug, NifTaggedEnum)]
enum NifDmapField {
    Vector(NifDmapVec),
    Scalar(NifDmapScalar),
}

#[derive(Debug, NifTaggedEnum)]
enum NifDmapScalar {
    Char(i8),
    Short(i16),
    Int(i32),
    Long(i64),
    Uchar(u8),
    Ushort(u16),
    Uint(u32),
    Ulong(u64),
    Float(NifSafeFloat<f32>),
    Double(NifSafeFloat<f64>),
    String(String)
}

#[derive(Debug, NifTaggedEnum)]
enum NifDmapVec {
    Char(Vec<i8>),
    Short(Vec<i16>),
    Int(Vec<i32>),
    Long(Vec<i64>),
    Uchar(Vec<u8>),
    Ushort(Vec<u16>),
    Uint(Vec<u32>),
    Ulong(Vec<u64>),
    Float(Vec<NifSafeFloat<f32>>),
    Double(Vec<NifSafeFloat<f64>>)
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

impl From<DmapField> for NifDmapField {
    fn from(field: DmapField) -> Self {
        match field {
            DmapField::Vector(v) => NifDmapField::Vector(v.into()),
            DmapField::Scalar(s) => NifDmapField::Scalar(s.into()),
        }
    }
}

impl From<DmapScalar> for NifDmapScalar {
    fn from(field: DmapScalar) -> Self {
        match field {
            DmapScalar::Char(c) => NifDmapScalar::Char(c),
            DmapScalar::Short(c) => NifDmapScalar::Short(c),
            DmapScalar::Int(c) => NifDmapScalar::Int(c),
            DmapScalar::Long(c) => NifDmapScalar::Long(c),
            DmapScalar::Uchar(c) => NifDmapScalar::Uchar(c),
            DmapScalar::Ushort(c) => NifDmapScalar::Ushort(c),
            DmapScalar::Uint(c) => NifDmapScalar::Uint(c),
            DmapScalar::Ulong(c) => NifDmapScalar::Ulong(c),
            DmapScalar::Float(c) => NifDmapScalar::Float(NifSafeFloat::from(c)),
            DmapScalar::Double(c) => NifDmapScalar::Double(NifSafeFloat::from(c)),
            DmapScalar::String(c) => NifDmapScalar::String(c)
        }
    }
}

impl From<DmapVec> for NifDmapVec {
    fn from(field: DmapVec) -> Self {
        match field {
            DmapVec::Char(c) => NifDmapVec::Char(c.into_iter().collect()),
            DmapVec::Short(c) => NifDmapVec::Short(c.into_iter().collect()),
            DmapVec::Int(c) => NifDmapVec::Int(c.into_iter().collect()),
            DmapVec::Long(c) => NifDmapVec::Long(c.into_iter().collect()),
            DmapVec::Uchar(c) => NifDmapVec::Uchar(c.into_iter().collect()),
            DmapVec::Ushort(c) => NifDmapVec::Ushort(c.into_iter().collect()),
            DmapVec::Uint(c) => NifDmapVec::Uint(c.into_iter().collect()),
            DmapVec::Ulong(c) => NifDmapVec::Ulong(c.into_iter().collect()),
            DmapVec::Float(c) => NifDmapVec::Float(c.into_iter().map(NifSafeFloat::from).collect()),
            DmapVec::Double(c) => NifDmapVec::Double(c.into_iter().map(NifSafeFloat::from).collect())
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

#[rustler::nif]
fn count_records(path: String) -> NifResult<usize> {
    let records = dmap::DmapRecord::read_file(path)
        .map_err(|e| rustler::Error::Term(Box::new(e.to_string())))?;

    Ok(records.len())
}

#[rustler::nif]
fn first_record_keys(path: String) -> NifResult<Vec<String>> {
    let first_record: DmapRecord = dmap::DmapRecord::sniff_file(path)
        .map_err(|e| Error::Term(Box::new(e.to_string())))?;

    Ok(first_record.keys().into_iter().cloned().collect())
}

#[rustler::nif]
fn first_record<'a>(path: String) -> NifResult<Vec<(String, NifDmapField)>> {
    let first_record: DmapRecord = DmapRecord::sniff_file(path)
        .map_err(|e| Error::Term(Box::new(e.to_string())))?;
    
    let fields = first_record
        .inner()
        .into_iter()
        .map(|(name, field)| {
            (name, field.into())
        })
        .collect();

    Ok(fields)
}


rustler::init!("Elixir.DarnDmap.Native");
