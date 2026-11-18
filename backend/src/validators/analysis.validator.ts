
import type {
  ProductAnalysisInput,
} from '../types/analysis.types';

import { AppError } from '../utils/error.util';

const MAX_IMAGES = 5;
const MAX_IMAGE_SIZE = 10 * 1024 * 1024;

const ALLOWED_IMAGE_TYPES = [
  'image/jpeg',
  'image/png',
  'image/webp',
];

export interface ValidatedAnalysisRequest {
  product: ProductAnalysisInput;
  images: File[];
}

function getRequiredString(
  formData: FormData,
  field: string,
): string {
  const value = formData.get(field);

  if (typeof value !== 'string' || !value.trim()) {
    throw new AppError(
      `${field} is required.`,
      'VALIDATION_ERROR',
      400,
    );
  }

  return value.trim();
}

function getOptionalString(
  formData: FormData,
  field: string,
): string | undefined {
  const value = formData.get(field);

  if (typeof value !== 'string') {
    return undefined;
  }

  return value.trim() || undefined;
}


export function validateAnalysisForm(
  formData: FormData,
): ValidatedAnalysisRequest {
  const category = getRequiredString(formData, 'category');
  const subcategory = getRequiredString(formData, 'subcategory');
  const productName = getRequiredString(formData, 'productName');
  const currency = getRequiredString(formData, 'currency');
  const condition = getRequiredString(formData, 'condition');

  const askingPriceValue = getRequiredString(
    formData,
    'askingPrice',
  );

  const askingPrice = Number(askingPriceValue);

  if (!Number.isFinite(askingPrice) || askingPrice <= 0) {
    throw new AppError(
      'Asking price must be a valid positive number.',
      'INVALID_ASKING_PRICE',
      400,
    );
  }

  const imageEntries = formData.getAll('images');

  if (
    imageEntries.length < 1 ||
    imageEntries.length > MAX_IMAGES ||
    !imageEntries.every((value) => value instanceof File)
  ) {
    throw new AppError(
      `Please provide between 1 and ${MAX_IMAGES} valid product images.`,
      'INVALID_IMAGE_COUNT',
      400,
    );
  }

  const images = imageEntries as File[];

  for (const image of images) {
    if (!ALLOWED_IMAGE_TYPES.includes(image.type)) {
      throw new AppError(
        'Only JPEG, PNG, and WebP images are supported.',
        'UNSUPPORTED_IMAGE_TYPE',
        400,
      );
    }

    if (image.size === 0 || image.size > MAX_IMAGE_SIZE) {
      throw new AppError(
        'Each image must be smaller than 10 MB and cannot be empty.',
        'INVALID_IMAGE_SIZE',
        400,
      );
    }
  }

  const model = getOptionalString(formData, 'model');
  const sellerDescription = getOptionalString(
    formData,
    'sellerDescription',
  );

  const product: ProductAnalysisInput = {
    category,
    subcategory,
    productName,
    currency,
    condition,
    askingPrice,
    ...(model ? { model } : {}),
    ...(sellerDescription ? { sellerDescription } : {}),
  };

  return {
    product,
    images,
  };
}


