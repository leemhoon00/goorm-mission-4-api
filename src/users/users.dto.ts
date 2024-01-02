import { IsString, IsNumber } from 'class-validator';

export class CreateUserDto {
  @IsString()
  name: string;
}

export class GetUsersDto {
  @IsNumber()
  id: number;

  @IsString()
  name: string;
}
