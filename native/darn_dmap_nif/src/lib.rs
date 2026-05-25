use std::collections::btree_map::Keys;

use dmap::{DmapRecord, Record};
use dmap::types::{DmapField, DmapScalar, DmapVec};

use rustler::{Atom, Encoder, Env, Error, NifMap, NifResult, NifTaggedEnum, Term};

#[derive(Debug, NifTaggedEnum)]
enum ExDmapField {
    Vector(ExDmapVec),
    Scalar(ExDmapScalar),
}

#[derive(Debug, NifTaggedEnum)]
enum ExDmapScalar {
    Char(i8),
    Short(i16),
    Int(i32),
    Long(i64),
    Uchar(u8),
    Ushort(u16),
    Uint(u32),
    Ulong(u64),
    Float(f64),
    Double(f64),
    String(String)
}

#[derive(Debug, NifTaggedEnum)]
enum ExDmapVec {
    Char(Vec<i8>),
    Short(Vec<i16>),
    Int(Vec<i32>),
    Long(Vec<i64>),
    Uchar(Vec<u8>),
    Ushort(Vec<u16>),
    Uint(Vec<u32>),
    Ulong(Vec<u64>),
    Float(Vec<f64>),
    Double(Vec<f64>)
}

impl From<DmapField> for ExDmapField {
    fn from(field: DmapField) -> Self {
        match field {
            DmapField::Vector(v) => ExDmapField::Vector(v.into()),
            DmapField::Scalar(s) => ExDmapField::Scalar(s.into()),
        }
    }
}

impl From<DmapScalar> for ExDmapScalar {
    fn from(field: DmapScalar) -> Self {
        match field {
            DmapScalar::Char(c) => ExDmapScalar::Char(c),
            DmapScalar::Short(c) => ExDmapScalar::Short(c),
            DmapScalar::Int(c) => ExDmapScalar::Int(c),
            DmapScalar::Long(c) => ExDmapScalar::Long(c),
            DmapScalar::Uchar(c) => ExDmapScalar::Uchar(c),
            DmapScalar::Ushort(c) => ExDmapScalar::Ushort(c),
            DmapScalar::Uint(c) => ExDmapScalar::Uint(c),
            DmapScalar::Ulong(c) => ExDmapScalar::Ulong(c),
            DmapScalar::Float(c) => ExDmapScalar::Float(c as f64),
            DmapScalar::Double(c) => ExDmapScalar::Double(c),
            DmapScalar::String(c) => ExDmapScalar::String(c)
        }
    }
}

impl From<DmapVec> for ExDmapVec {
    fn from(field: DmapVec) -> Self {
        match field {
            DmapVec::Char(c) => ExDmapVec::Char(c.into_iter().collect()),
            DmapVec::Short(c) => ExDmapVec::Short(c.into_iter().collect()),
            DmapVec::Int(c) => ExDmapVec::Int(c.into_iter().collect()),
            DmapVec::Long(c) => ExDmapVec::Long(c.into_iter().collect()),
            DmapVec::Uchar(c) => ExDmapVec::Uchar(c.into_iter().collect()),
            DmapVec::Ushort(c) => ExDmapVec::Ushort(c.into_iter().collect()),
            DmapVec::Uint(c) => ExDmapVec::Uint(c.into_iter().collect()),
            DmapVec::Ulong(c) => ExDmapVec::Ulong(c.into_iter().collect()),
            DmapVec::Float(c) => ExDmapVec::Float(c.iter().map(|v| *v as f64).collect()),
            DmapVec::Double(c) => ExDmapVec::Double(c.into_iter().collect())
        }
    }
}

mod atoms {
    rustler::atoms! {
        scalar,
        vector,
        char,
        short,
        int,
        long,
        uchar,
        ushort,
        uint,
        ulong,
        float,
        double,
        string
    }
}

fn encode_scalar<'a>(env: Env<'a>, s: DmapScalar) -> Term<'a> {
    match s {
        DmapScalar::Char(x) => (atoms::scalar(), atoms::char(), x).encode(env),
        DmapScalar::Short(x) => (atoms::scalar(), atoms::short(), x).encode(env),
        DmapScalar::Int(x) => (atoms::scalar(), atoms::int(), x).encode(env),
        DmapScalar::Long(x) => (atoms::scalar(), atoms::long(), x).encode(env),
        DmapScalar::Uchar(x) => (atoms::scalar(), atoms::uchar(), x).encode(env),
        DmapScalar::Ushort(x) => (atoms::scalar(), atoms::ushort(), x).encode(env),
        DmapScalar::Uint(x) => (atoms::scalar(), atoms::uint(), x).encode(env),
        DmapScalar::Ulong(x) => (atoms::scalar(), atoms::ulong(), x).encode(env),
        DmapScalar::Float(x) => (atoms::scalar(), atoms::float(), x as f64).encode(env),
        DmapScalar::Double(x) => (atoms::scalar(), atoms::double(), x).encode(env),
        DmapScalar::String(x) => (atoms::scalar(), atoms::string(), x).encode(env),
    }
}

fn encode_vector<'a>(env: Env<'a>, v: DmapVec) -> Term<'a> {
    match v {
        DmapVec::Char(x) => (atoms::vector(), atoms::char(), x.iter().cloned().collect::<Vec<_>>()).encode(env),
        DmapVec::Short(x) => (atoms::vector(), atoms::short(), x.iter().cloned().collect::<Vec<_>>()).encode(env),
        DmapVec::Int(x) => (atoms::vector(), atoms::int(), x.iter().cloned().collect::<Vec<_>>()).encode(env),
        DmapVec::Long(x) => (atoms::vector(), atoms::long(), x.iter().cloned().collect::<Vec<_>>()).encode(env),
        DmapVec::Uchar(x) => (atoms::vector(), atoms::uchar(), x.iter().cloned().collect::<Vec<_>>()).encode(env),
        DmapVec::Ushort(x) => (atoms::vector(), atoms::ushort(), x.iter().cloned().collect::<Vec<_>>()).encode(env),
        DmapVec::Uint(x) => (atoms::vector(), atoms::uint(), x.iter().cloned().collect::<Vec<_>>()).encode(env),
        DmapVec::Ulong(x) => (atoms::vector(), atoms::ulong(), x.iter().cloned().collect::<Vec<_>>()).encode(env),
        // DmapVec::Float(x) => (atoms::vector(), atoms::float(), x.iter().map(|v| *v as f64).collect::<Vec<f64>>()).encode(env),
        DmapVec::Float(x) => (atoms::vector(), atoms::float(), x.iter().map(|v| v.to_string()).collect::<Vec<String>>()).encode(env),
        DmapVec::Double(x) => (atoms::vector(), atoms::double(), x.iter().cloned().collect::<Vec<_>>()).encode(env),
    }
}

#[rustler::nif]
fn read_records(path: String) -> NifResult<usize> {
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
fn first_record<'a>(env: Env<'a>, path: String) -> NifResult<Vec<(String, Term<'a>)>> {
    let first_record: DmapRecord = DmapRecord::sniff_file(path)
        .map_err(|e| Error::Term(Box::new(e.to_string())))?;
    
    let fields = first_record
        .inner()
        .iter()
        .map(|(k, v)| {
            let term = match v.clone() {
                DmapField::Vector(v) => encode_vector(env, v),
                DmapField::Scalar(s) => encode_scalar(env, s),
            };

            (k.clone(), term)
        })
        .collect();

    Ok(fields)
}

rustler::init!("Elixir.DarnDmap.Native");
