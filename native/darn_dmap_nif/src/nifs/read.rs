use dmap::{DmapRecord, Record};
use dmap::types::{DmapField, DmapScalar, DmapVec};
use rustler::{Decoder, Encoder, Env, Error, NifResult, NifTaggedEnum, Term};
use crate::encode::{
    NifDmapField,
    NifDmapScalar,
    NifDmapVec,
    NifSafeFloat
};

#[rustler::nif]
pub fn count_records(path: String) -> NifResult<usize> {
    let records = dmap::DmapRecord::read_file(path)
        .map_err(|e| rustler::Error::Term(Box::new(e.to_string())))?;

    Ok(records.len())
}

#[rustler::nif]
pub fn first_record_keys(path: String) -> NifResult<Vec<String>> {
    let first_record: DmapRecord = dmap::DmapRecord::sniff_file(path)
        .map_err(|e| Error::Term(Box::new(e.to_string())))?;

    Ok(first_record.keys().into_iter().cloned().collect())
}

#[rustler::nif]
pub fn first_record<'a>(path: String) -> NifResult<Vec<(String, NifDmapField)>> {
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